-module(solution).
-export([domino/1]).

domino(Board) ->
    M = length(Board),
    N = length(hd(Board)),
    Visited = array:new([{size, M}, {default, array:new([{size, N}, {default, false}])}]),
    {Count, _} = dfs(Board, Visited, 0, 0, M, N, 0),
    Count.

dfs(Board, Visited, I, J, M, N, Count) ->
    case I >= M of
        true -> {Count, Visited};
        false ->
            case J >= N of
                true -> dfs(Board, Visited, I + 1, 0, M, N, Count);
                false ->
                    case array:get(I, array:get(J, Visited)) of
                        true -> dfs(Board, Visited, I, J + 1, M, N, Count);
                        false ->
                            case array:get(I, Board) of
                                Row when J < N - 1, array:get(J, Row) == 0, array:get(J + 1, Row) == 0 ->
                                    NewVisited = mark_visited(Visited, I, J, I, J + 1, M, N),
                                    dfs(Board, NewVisited, I, J + 2, M, N, Count + 1);
                                _ ->
                                    case I < M - 1 of
                                        true ->
                                            NextRow = array:get(I + 1, Board),
                                            case array:get(J, NextRow) == 0 andalso array:get(J, array:get(I + 1, Visited)) == false of
                                                true ->
                                                    NewVisited = mark_visited(Visited, I, J, I + 1, J, M, N),
                                                    dfs(Board, NewVisited, I, J + 1, M, N, Count + 1);
                                                false ->
                                                    dfs(Board, Visited, I, J + 1, M, N, Count)
                                            end;
                                        false ->
                                            dfs(Board, Visited, I, J + 1, M, N, Count)
                                    end
                            end
                    end
            end
    end.

mark_visited(Visited, I1, J1, I2, J2, M, N) ->
    V1 = array:get(I1, Visited),
    V1Updated = array:set(J1, true, V1),
    Visited1 = array:set(I1, V1Updated, Visited),
    V2 = array:get(I2, Visited1),
    V2Updated = array:set(J2, true, V2),
    array:set(I2, V2Updated, Visited1).