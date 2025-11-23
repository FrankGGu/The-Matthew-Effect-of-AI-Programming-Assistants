-module(solution).
-export([shortestPathBinaryMatrix/1]).

shortestPathBinaryMatrix(Matrix) ->
    case length(Matrix) of
        0 -> -1;
        N when N =:= 1, hd(Matrix) == [0] -> 1;
        N when N =:= 1 -> -1;
        _ -> bfs(Matrix)
    end.

bfs(Matrix) ->
    N = length(Matrix),
    M = length(hd(Matrix)),
    Start = {0, 0},
    End = {N - 1, M - 1},
    Queue = [{Start, 1}],
    Visited = maps:from_list([{Start, true}]),
    bfs_helper(Queue, Visited, End, N, M).

bfs_helper([], _, _, _, _) -> -1;
bfs_helper([{Pos, Dist} | Rest], Visited, End, N, M) ->
    if
        Pos == End -> Dist;
        true ->
            NewVisited = visit_neighbors(Pos, Visited, N, M),
            NewQueue = lists:foldl(fun(NPos, Acc) -> 
                case maps:is_key(NPos, NewVisited) of
                    false -> [{NPos, Dist + 1} | Acc];
                    true -> Acc
                end
            end, Rest, neighbors(Pos)),
            bfs_helper(NewQueue, NewVisited, End, N, M)
    end.

visit_neighbors({X, Y}, Visited, N, M) ->
    lists:foldl(fun({DX, DY}, Acc) ->
        NewPos = {X + DX, Y + DY},
        if
            within_bounds(NewPos, N, M), 
            not maps:is_key(NewPos, Visited) -> 
                maps:put(NewPos, true, Acc);
            true -> Acc
        end
    end, Visited, [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]).

neighbors({X, Y}) ->
    [{X + DX, Y + DY} || {DX, DY} <- [{-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1}]].

within_bounds({X, Y}, N, M) ->
    X >= 0, X < N, Y >= 0, Y < M, hd(get_elem(X, N)) =:= 0.

get_elem(Index, N) ->
    lists:nth(Index + 1, lists:seq(1, N)).