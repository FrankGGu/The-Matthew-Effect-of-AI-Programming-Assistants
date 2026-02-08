-module(solution).
-export([replace_elements/1]).

replace_elements(Arr) ->
    ReversedArr = lists:reverse(Arr),
    replace_elements_recursive(ReversedArr, -1, []).

replace_elements_recursive([], _CurrentMaxRight, Acc) ->
    Acc;
replace_elements_recursive([H | T], CurrentMaxRight, Acc) ->
    NewAcc = [CurrentMaxRight | Acc],
    NewCurrentMaxRight = max(CurrentMaxRight, H),
    replace_elements_recursive(T, NewCurrentMaxRight, NewAcc).