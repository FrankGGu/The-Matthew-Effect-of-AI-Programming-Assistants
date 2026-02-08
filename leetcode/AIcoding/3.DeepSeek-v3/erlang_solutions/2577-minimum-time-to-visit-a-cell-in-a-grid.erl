-module(solution).
-export([minimum_time/1]).

minimum_time(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Visited = sets:new(),
    PriorityQueue = [{0, 0, 0}],
    minimum_time(Grid, M, N, Visited, PriorityQueue).

minimum_time(Grid, M, N, Visited, PriorityQueue) ->
    case PriorityQueue of
        [] -> -1;
        [{Time, X, Y} | Rest] ->
            case {X, Y} of
                {M - 1, N - 1} -> Time;
                _ ->
                    case sets:is_element({X, Y}, Visited) of
                        true ->
                            minimum_time(Grid, M, N, Visited, Rest);
                        false ->
                            NewVisited = sets:add_element({X, Y}, Visited),
                            Neighbors = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
                            ValidNeighbors = lists:filter(fun({I, J}) ->
                                I >= 0 andalso I < M andalso J >= 0 andalso J < N andalso
                                not sets:is_element({I, J}, NewVisited) andalso
                                (Time + 1 >= Grid:get(I, J) orelse (Time + 1) rem 2 == (Grid:get(I, J) rem 2)
                            end, Neighbors),
                            NewQueue = lists:foldl(fun({I, J}, Acc) ->
                                RequiredTime = case Time + 1 >= Grid:get(I, J) of
                                    true -> Time + 1;
                                    false -> Grid:get(I, J) + ((Time + 1 - Grid:get(I, J)) rem 2)
                                end,
                                [{RequiredTime, I, J} | Acc]
                            end, Rest, ValidNeighbors),
                            SortedQueue = lists:sort(fun({T1, _, _}, {T2, _, _}) -> T1 =< T2 end, NewQueue),
                            minimum_time(Grid, M, N, NewVisited, SortedQueue)
                    end
            end
    end.