-module(solution).
-export([count_beautiful_pairs/1]).

count_beautiful_pairs(List) ->
    N = length(List),
    Count = lists:sum(lists:map(fun(X) -> lists:sum(lists:map(fun(Y) -> if (X - Y) rem 2 =:= 1 -> 1; true -> 0 end) (lists:filter(fun(Z) -> Z /= X end, List))) end, List)),
    Count div 2.