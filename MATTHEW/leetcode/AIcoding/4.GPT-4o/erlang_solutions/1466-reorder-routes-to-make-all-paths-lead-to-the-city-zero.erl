-module(solution).
-export([minReorder/2]).

minReorder(N, Connections) ->
    Graph = lists:foldl(fun({A, B}, Acc) -> 
                            [{A, B} | Acc] ++ [{B, A}] 
                         end, [], Connections),
    min_reorder(0, Graph, lists:seq(0, N-1), []).

min_reorder(City, Graph, Visited, Acc) ->
    case lists:member(City, Visited) of
        true -> Acc;
        false ->
            NewVisited = [City | Visited],
            NextCities = lists:filter(fun({A, B}) -> A =:= City end, Graph),
            lists:foldl(fun({_, B}, Count) -> 
                            if
                                lists:member(B, NewVisited) -> Count;
                                true -> min_reorder(B, Graph, NewVisited, Count + 1)
                            end
                         end, Acc, NextCities)
    end.