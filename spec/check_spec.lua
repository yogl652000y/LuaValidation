describe("Validation of check() calls", function()
  local v = require("main")

  stub(v, "display")

  it("Must use display affirmative constraint", function()
    v.dummy(false):check("whatever")

    assert.stub(v.display).was.called_with('"whatever" have to be "false"')
  end)

  it("Must use display negative constraint", function()
    v.never(v.dummy(true)):check("whatever")

    assert.stub(v.display).was.called_with('"whatever" have not to be "true"')
  end)

  it("Must use display custom message", function()
    v.dummy(false):check("whatever", {message = "This is not right"})

    assert.stub(v.display).was.called_with("This is not right")
  end)

  it("Must use translate message", function()
    v.dummy(false):check(
      "whatever",
      {
        translator = function (message)
          return '{{placeholder}} deve ser {{result}}'
        end
      }
    )

    assert.stub(v.display).was.called_with('"whatever" deve ser "false"')
  end)
end)
