-module(shortest_bridge).
-export([shortest_bridge/1]).

shortest_bridge(Island) ->
    {X, Y} = find_island(Island),
    Visited = mark_island(Island, X, Y),
    min_distance(Visited, Island).

find_island(Island) ->
    lists:foldl(fun({Row, Col}, Acc) ->
        case lists:nth(Row + 1, Island) of
            {1, _} -> {Row, Col};
            _ -> Acc
        end
    end, {none, none}, lists:seq(0, length(Island) - 1)).

mark_island(Island, X, Y) ->
    mark(Island, X, Y, []).

mark(Island, X, Y, Visited) ->
    case lists:nth(X + 1, Island) of
        {1, _} when lists:member({X, Y}, Visited) -> Visited;
        {1, _} -> 
            NewVisited = [{X, Y} | Visited],
            lists:foldl(fun(Dir, Acc) -> 
                mark(Island, X + elem(Dir, 0), Y + elem(Dir, 1), Acc)
            end, NewVisited, [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]);
        _ -> Visited
    end.

min_distance(Visited, Island) ->
    Queue = [{X, Y, 0} || {X, Y} <- Visited],
    min_dist(Queue, Island, []).

min_dist([], _, _) -> -1;
min_dist([{X, Y, Dist} | Rest], Island, Visited) ->
    case lists:nth(X + 1, Island) of
        {0, _} -> 
            case lists:member({X, Y}, Visited) of
                true -> min_dist(Rest, Island, Visited);
                false -> 
                    NewVisited = [{X, Y} | Visited],
                    NewQueue = lists:foldl(fun(Dir, Acc) -> 
                        [{X + elem(Dir, 0), Y + elem(Dir, 1), Dist + 1} | Acc]
                    end, Rest, [{0, 1}, {1, 0}, {0, -1}, {-1, 0}]),
                    min_dist(NewQueue, Island, NewVisited);
            end;
        _ -> min_dist(Rest, Island, Visited)
    end.