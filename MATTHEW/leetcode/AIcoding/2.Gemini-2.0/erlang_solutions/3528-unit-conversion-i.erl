-module(unit_conversion_i).
-export([solve/1]).

solve(Input) ->
    {Value, Unit} = parse_input(Input),
    case Unit of
        "Celsius" ->
            Fahrenheit = Value * 9 / 5 + 32,
            list_to_float(io_lib:format("~.2f", [Fahrenheit]));
        "Fahrenheit" ->
            Celsius = (Value - 32) * 5 / 9,
            list_to_float(io_lib:format("~.2f", [Celsius]))
    end.

parse_input(Input) ->
    [ValueStr, Unit] = string:split(Input, " ", all),
    Value = list_to_float(ValueStr),
    {Value, Unit}.