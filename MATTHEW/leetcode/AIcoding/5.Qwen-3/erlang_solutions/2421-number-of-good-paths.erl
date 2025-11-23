-module(number_of_good_paths).
-export([num_good_paths/1]).

num_good_paths(Graph) ->
    Nodes = maps:keys(Graph),
    MaxVal = lists:max([hd(Val) || Val <- maps:values(Graph)]),
    Map = maps:from_list([{Node, {0, 0}} || Node <- Nodes]),
    Count = maps:from_list([{Val, 0} || Val <- lists:seq(1, MaxVal)]),
    num_good_paths(Graph, Map, Count, MaxVal).

num_good_paths(_, _, Count, _) ->
    maps:fold(fun(_, V, Acc) -> Acc + V end, 0, Count).

num_good_paths(Graph, Map, Count, MaxVal) ->
    SortedNodes = lists:sort([{Val, Node} || Node <- maps:keys(Graph), {Val, _} <- [lists:hd(maps:get(Node, Graph))]]),
    num_good_paths(Graph, Map, Count, MaxVal, SortedNodes).

num_good_paths(_, _, Count, _, []) ->
    maps:fold(fun(_, V, Acc) -> Acc + V end, 0, Count);
num_good_paths(Graph, Map, Count, MaxVal, [{Val, Node} | Rest]) ->
    {_, Neighbors} = lists:split(1, maps:get(Node, Graph)),
    NewMap = update_map(Map, Node, Val),
    NewCount = update_count(Count, Val, 1),
    num_good_paths(Graph, NewMap, NewCount, MaxVal, Rest).

update_map(Map, Node, Val) ->
    lists:foldl(fun(Neighbor, M) ->
        case maps:get(Neighbor, M, {0, 0}) of
            {V, C} when V == Val ->
                maps:update(Neighbor, {V, C + 1}, M);
            _ ->
                M
        end
    end, Map, maps:keys(Graph)).

update_count(Count, Val, Add) ->
    maps:update(Val, maps:get(Val, Count) + Add, Count).