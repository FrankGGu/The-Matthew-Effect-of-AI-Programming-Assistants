-module(solution).
-export([relative_sort_array/2]).

relative_sort_array(A, B) ->
    SortedB = lists:sort(B),
    ACount = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(_) -> 1 end, fun(N) -> N + 1 end, Acc) end, maps:new(), A),
    lists:flatmap(fun(X) -> lists:duplicate(maps:get(X, ACount, 0), X) end, SortedB) ++ lists:sort(fun(X, Y) -> X < Y end, lists:filter(fun(X) -> maps:get(X, ACount, 0) == 0 end, A)).