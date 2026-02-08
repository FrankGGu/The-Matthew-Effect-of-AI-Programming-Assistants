-module(solution).
-export([find_smallest_set_of_vertices/2]).

find_smallest_set_of_vertices(N, Edges) ->
    InDegrees = array:new(N, 0),

    UpdatedInDegrees = lists:foldl(
        fun([_U, V], AccInDegrees) ->
            CurrentInDegree = array:get(V, AccInDegrees),
            array:set(V, CurrentInDegree + 1, AccInDegrees)
        end,
        InDegrees,
        Edges
    ),

    collect_zero_in_degree_nodes(0, N, UpdatedInDegrees, []).

collect_zero_in_degree_nodes(CurrentNode, N, InDegreesArray, AccResult) when CurrentNode < N ->
    case array:get(CurrentNode, InDegreesArray) of
        0 ->
            collect_zero_in_degree_nodes(CurrentNode + 1, N, InDegreesArray, [CurrentNode | AccResult]);
        _ ->
            collect_zero_in_degree_nodes(CurrentNode + 1, N, InDegreesArray, AccResult)
    end;
collect_zero_in_degree_nodes(_CurrentNode, _N, _InDegreesArray, AccResult) ->
    lists:reverse(AccResult).