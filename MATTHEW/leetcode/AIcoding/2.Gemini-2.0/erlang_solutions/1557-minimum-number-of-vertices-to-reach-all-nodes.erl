-module(minimum_vertices).
-export([find_smallest_set_of_vertices/1]).

find_smallest_set_of_vertices(N, Edges) ->
    InDegree = lists:foldl(fun([_, V], Acc) ->
                                    maps:update(V, maps:get(V, Acc, 0) + 1, Acc)
                            end, maps:new(), Edges),

    lists:filter(fun(V) -> not maps:is_key(V, InDegree) end, lists:seq(0, N - 1)).