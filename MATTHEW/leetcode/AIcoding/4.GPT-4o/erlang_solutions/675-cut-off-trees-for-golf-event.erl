-module(solution).
-export([cut_off_trees/1]).

cut_off_trees(Trees) ->
    {ok, Start} = find_start(Trees),
    SortedTrees = lists:sort(fun({_, _, H1}, {_, _, H2}) -> H1 < H2 end, Trees),
    cut_trees(Start, SortedTrees, Trees, []).

find_start(Trees) ->
    {Row, Col} = lists:foldl(fun({_, _, _}, {R, C}) -> {R, C} end, {0, 0}, Trees),
    {ok, {Row, Col}}.

cut_trees(_, [], _, Distances) ->
    lists:sum(Distances);
cut_trees({X, Y}, [{Row, Col, _} | Rest], Trees, Distances) ->
    case bfs({X, Y}, {Row, Col}, Trees, [], 0) of
        -1 -> -1;
        Distance -> cut_trees({Row, Col}, Rest, Trees, [Distance | Distances])
    end.

bfs(Start, Goal, Trees, Visited, Distance) ->
    if
        Start == Goal -> Distance;
        true ->
            Neighbors = find_neighbors(Start, Trees, Visited),
            lists:foldl(fun(Neighbor, Acc) -> 
                case Acc of
                    -1 -> Acc;
                    _ -> bfs(Neighbor, Goal, Trees, [Start | Visited], Distance + 1)
                end
            end, -1, Neighbors)
    end.

find_neighbors({X, Y}, Trees, Visited) ->
    NeighborOffsets = [{1, 0}, {0, 1}, {-1, 0}, {0, -1}],
    lists:filter(fun({NX, NY, _}) -> 
        NX >= 0, NY >= 0, 
        not lists:member({NX, NY}, Visited)
    end, 
    lists:map(fun({DX, DY}) -> {X + DX, Y + DY, 0} end, NeighborOffsets)).