-module(replace_elements).
-export([replace_elements/1]).

replace_elements(Arr) ->
    replace_elements(Arr, []).

replace_elements([], Acc) ->
    lists:reverse(Acc);
replace_elements([H], Acc) ->
    lists:reverse([ -1 | Acc]);
replace_elements([H | T], Acc) ->
    Max = lists:max(T),
    replace_elements(T, [Max | Acc]).