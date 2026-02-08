-module(solution).
-export([maximum_sum_edge_values/2]).

maximum_sum_edge_values(N, Edges) ->
    Graph = lists:foldl(fun({A, B, C}, Acc) ->
        maps:update_with(A, fun(X) -> X + C end, fun() -> C end, Acc),
        maps:update_with(B, fun(X) -> X + C end, fun() -> C end, Acc)
    end, maps:from_list(lists:map(fun(X) -> {X, 0} end, lists:seq(1, N))), Edges),
    lists:max(maps:values(Graph)).