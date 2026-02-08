-module(roman_to_integer).
-export([roman_to_int/1]).

roman_to_int(Roman) ->
    roman_to_int(Roman, 0, 0).

roman_to_int([], Total, _) ->
    Total;
roman_to_int([H | T], Total, PrevValue) ->
    Value = get_value(H),
    if
        Value > PrevValue ->
            Total + Value - 2 * PrevValue;
        true ->
            Total + Value
    end,
    roman_to_int(T, Total + Value, Value).

get_value($I) -> 1;
get_value($V) -> 5;
get_value($X) -> 10;
get_value($L) -> 50;
get_value($C) -> 100;
get_value($D) -> 500;
get_value($M) -> 1000.