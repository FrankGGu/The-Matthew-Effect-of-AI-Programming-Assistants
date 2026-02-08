-module(reach_all_nodes).
-export([find_min_vertices/1]).

find_min_vertices(Edges) ->
    Nodes = lists:usort(lists:flatten([A || [A, _] <- Edges] ++ [B || [_, B] <- Edges])),
    InDegree = lists:foldl(fun([A, B], Acc) -> 
        maps:update(B, maps:get(B, Acc, 0) + 1, Acc) 
    end, #{}, Edges),
    [Node || Node <- Nodes, maps:get(Node, InDegree, 0) == 0].