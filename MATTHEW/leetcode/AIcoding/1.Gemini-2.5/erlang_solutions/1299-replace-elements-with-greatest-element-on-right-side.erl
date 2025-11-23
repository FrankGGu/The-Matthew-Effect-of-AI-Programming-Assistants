-module(solution).
-export([replace_elements/1]).

replace_elements(Arr) ->
    replace_elements_r(lists:reverse(Arr), -1, []).

replace_elements_r([], _CurrentMaxRight, Acc) ->
    Acc;
replace_elements_r([H|T], CurrentMaxRight, Acc) ->
    NewAcc = [CurrentMaxRight | Acc],
    NewCurrentMaxRight = max(CurrentMaxRight, H),
    replace_elements_r(T, NewCurrentMaxRight, NewAcc).