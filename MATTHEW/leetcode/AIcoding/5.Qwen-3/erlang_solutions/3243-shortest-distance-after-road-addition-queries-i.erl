-module(solution).
-export([shortestDistance/2]).

shortestDistance(Roads, Queries) ->
    Graph = buildGraph(Roads),
    lists:map(fun(Query) -> dijkstra(Graph, Query) end, Queries).

buildGraph(Roads) ->
    maps:from_list([ {A, maps:get(A, Graph, [] ++ [B])} || {A, B} <- Roads, Graph <- [maps:new()] ]).

dijkstra(Graph, Target) ->
    {_, Distances} = dijkstra_helper(Graph, 0, 1, maps:from_list([{0, 0}]), maps:from_list([{0, true}]), Target),
    maps:get(Target, Distances, -1).

dijkstra_helper(_, _, _, Distances, Visited, _) when maps:size(Visited) == 0 ->
    {0, Distances};
dijkstra_helper(Graph, CurrentNode, CurrentDist, Distances, Visited, Target) ->
    Neighbors = maps:get(CurrentNode, Graph, []),
    UpdatedDistances = updateNeighbors(Neighbors, CurrentNode, CurrentDist, Distances),
    NextNode = findNextNode(Visited, UpdatedDistances),
    case NextNode of
        none ->
            {CurrentDist, UpdatedDistances};
        _ ->
            dijkstra_helper(Graph, NextNode, maps:get(NextNode, UpdatedDistances), UpdatedDistances, maps:put(NextNode, true, Visited), Target)
    end.

updateNeighbors([], _, _, Distances) ->
    Distances;
updateNeighbors([H | T], CurrentNode, CurrentDist, Distances) ->
    NewDist = CurrentDist + 1,
    UpdatedDist = case maps:is_key(H, Distances) of
                      true ->
                          min(maps:get(H, Distances), NewDist);
                      false ->
                          NewDist
                  end,
    updateNeighbors(T, CurrentNode, CurrentDist, maps:put(H, UpdatedDist, Distances)).

findNextNode(Visited, Distances) ->
    Candidates = maps:keys(Distances),
    lists:foldl(fun(Node, Acc) ->
                    if
                        maps:is_key(Node, Visited) -> Acc;
                        true ->
                            case Acc of
                                none -> Node;
                                _ -> 
                                    if maps:get(Node, Distances) < maps:get(Acc, Distances) -> Node;
                                       true -> Acc
                                    end
                            end
                    end
                end, none, Candidates).