-module(solution).
-export([maximum_minutes/1]).

maximum_minutes(Grid) ->
    {M, N} = {length(Grid), length(hd(Grid))},
    Fire = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            case lists:nth(J, lists:nth(I, Grid)) of
                1 -> [{I-1, J-1} | Acc1];
                _ -> Acc1
            end
        end, Acc, lists:seq(1, N))
    end, [], lists:seq(1, M)),
    case Fire of
        [] -> 
            case bfs(Grid, M, N, 0, 0, M-1, N-1, Fire) of
                infinity -> 1000000000;
                _ -> 1000000000
            end;
        _ ->
            MaxTime = 0,
            case bfs(Grid, M, N, 0, 0, M-1, N-1, Fire) of
                infinity -> 1000000000;
                _ -> binary_search(Grid, M, N, Fire, 0, 20000)
            end
    end.

binary_search(Grid, M, N, Fire, Low, High) ->
    if
        Low > High -> High;
        true ->
            Mid = (Low + High) div 2,
            case bfs(Grid, M, N, 0, 0, M-1, N-1, Fire, Mid) of
                true -> binary_search(Grid, M, N, Fire, Mid + 1, High);
                false -> binary_search(Grid, M, N, Fire, Low, Mid - 1)
            end
    end.

bfs(Grid, M, N, StartI, StartJ, EndI, EndJ, Fire) ->
    Queue = queue:in({StartI, StartJ, 0}, queue:new()),
    Visited = sets:from_list([{StartI, StartJ}]),
    bfs_helper(Grid, M, N, EndI, EndJ, Fire, Queue, Visited).

bfs_helper(Grid, M, N, EndI, EndJ, Fire, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true -> infinity;
        false ->
            {{value, {I, J, Time}}, Q} = queue:out(Queue),
            if
                I =:= EndI andalso J =:= EndJ -> Time;
                true ->
                    NewVisited = sets:add_element({I, J}, Visited),
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    NewQueue = lists:foldl(fun({Di, Dj}, Acc) ->
                        NewI = I + Di,
                        NewJ = J + Dj,
                        if
                            NewI >= 0, NewI < M, NewJ >= 0, NewJ < N ->
                                case lists:nth(NewJ + 1, lists:nth(NewI + 1, Grid)) of
                                    0 ->
                                        case sets:is_element({NewI, NewJ}, NewVisited) of
                                            false ->
                                                case is_safe(NewI, NewJ, Time + 1, Fire, M, N, Grid) of
                                                    true -> queue:in({NewI, NewJ, Time + 1}, Acc);
                                                    false -> Acc
                                                end;
                                            true -> Acc
                                        end;
                                    _ -> Acc
                                end;
                            true -> Acc
                        end
                    end, Q, Directions),
                    bfs_helper(Grid, M, N, EndI, EndJ, Fire, NewQueue, NewVisited)
            end
    end.

bfs(Grid, M, N, StartI, StartJ, EndI, EndJ, Fire, Wait) ->
    Queue = queue:in({StartI, StartJ, Wait}, queue:new()),
    Visited = sets:from_list([{StartI, StartJ}]),
    bfs_wait_helper(Grid, M, N, EndI, EndJ, Fire, Queue, Visited).

bfs_wait_helper(Grid, M, N, EndI, EndJ, Fire, Queue, Visited) ->
    case queue:is_empty(Queue) of
        true -> false;
        false ->
            {{value, {I, J, Time}}, Q} = queue:out(Queue),
            if
                I =:= EndI andalso J =:= EndJ -> true;
                true ->
                    NewVisited = sets:add_element({I, J}, Visited),
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    NewQueue = lists:foldl(fun({Di, Dj}, Acc) ->
                        NewI = I + Di,
                        NewJ = J + Dj,
                        if
                            NewI >= 0, NewI < M, NewJ >= 0, NewJ < N ->
                                case lists:nth(NewJ + 1, lists:nth(NewI + 1, Grid)) of
                                    0 ->
                                        case sets:is_element({NewI, NewJ}, NewVisited) of
                                            false ->
                                                case is_safe(NewI, NewJ, Time + 1, Fire, M, N, Grid) of
                                                    true -> queue:in({NewI, NewJ, Time + 1}, Acc);
                                                    false -> Acc
                                                end;
                                            true -> Acc
                                        end;
                                    _ -> Acc
                                end;
                            true -> Acc
                        end
                    end, Q, Directions),
                    bfs_wait_helper(Grid, M, N, EndI, EndJ, Fire, NewQueue, NewVisited)
            end
    end.

is_safe(I, J, Time, Fire, M, N, Grid) ->
    lists:all(fun({Fi, Fj}) ->
        manhattan(I, J, Fi, Fj) > Time
    end, Fire).

manhattan(I1, J1, I2, J2) ->
    abs(I1 - I2) + abs(J1 - J2).