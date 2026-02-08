-module(solution).
-export([maximum_path_quality/3]).

maximum_path_quality(Graph, Start, MaxTime) ->
    Edges = lists:foldl(fun({A, B, C}, Acc) -> [{A, B, C} | [{B, A, C} | Acc]} end, [], Graph),
    maximum_path_quality_helper(Edges, Start, MaxTime, 0, [], 0).

maximum_path_quality_helper(_, _, 0, Quality, Visited, Quality) when Quality > 0 -> Quality;
maximum_path_quality_helper(Edges, Node, Time, Quality, Visited, MaxQuality) ->
    NewQuality = if lists:member(Node, Visited) -> Quality; true -> Quality + Node end,
    NewVisited = lists:append(Visited, [Node]),
    lists:max([maximum_path_quality_helper(Edges, B, Time - C, NewQuality, NewVisited, MaxQuality) || {A, B, C} <- Edges, A =:= Node, C =< Time]).