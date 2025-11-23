-module(solution).
-export([solve/1]).

solve(List) ->
    count_elements(List, #{}).

count_elements([], Acc) ->
    Acc;
count_elements([H|T], Acc) ->
    NewAcc = maps:update_with(H, fun(Count) -> Count + 1 end, 1, Acc),
    count_elements(T, NewAcc).