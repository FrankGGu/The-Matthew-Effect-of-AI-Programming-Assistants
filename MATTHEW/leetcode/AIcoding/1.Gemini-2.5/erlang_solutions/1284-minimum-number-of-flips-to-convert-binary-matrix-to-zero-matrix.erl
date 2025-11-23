-module(solution).
-export([minFlips/1]).

minFlips(Matrix) ->
    R = length(Matrix),
    C = length(hd(Matrix)),

    Q = queue:new(),
    Q1 = queue:in({Matrix, 0}, Q),

    Visited = maps:new(),
    Visited1 = maps:put(Matrix, true, Visited),

    bfs(Q1, Visited1, R, C).

bfs(Q, Visited, R, C) ->
    case queue:is_empty(Q) of
        true ->
            -1;
        false ->
            {{value, {CurrentMatrix, Count}}, Q1} = queue:out(Q),

            if is_zero_matrix(CurrentMatrix) ->
                Count;
            true ->
                {FinalQ, FinalVisited} = 
                    lists:foldl(fun(R_idx, {AccQ_r, AccVisited_r}) ->
                        lists:foldl(fun(C_idx, {AccQ_c, AccVisited_c}) ->
                            NextMatrix = do_flip(CurrentMatrix, R_idx, C_idx, R, C),
                            case maps:is_key(NextMatrix, AccVisited_c) of
                                true ->
                                    {AccQ_c, AccVisited_c};
                                false ->
                                    {queue:in({NextMatrix, Count + 1}, AccQ_c), maps:put(NextMatrix, true, AccVisited_c)}
                            end
                        end, {AccQ_r, AccVisited_r}, lists:seq(0, C - 1))
                    end, {Q1, Visited}, lists:seq(0, R - 1)),

                bfs(FinalQ, FinalVisited, R, C)
            end
    end.

is_zero_matrix(Matrix) ->
    lists:all(fun(Row) ->
        lists:all(fun(Cell) -> Cell == 0 end, Row)
    end, Matrix).

do_flip(Matrix, FlipR, FlipC, R_max, C_max) ->
    lists:mapi(fun(R_curr, Row) ->
        lists:mapi(fun(C_curr, Cell) ->
            if is_affected(R_curr, C_curr, FlipR, FlipC, R_max, C_max) ->
                1 - Cell;
            true ->
                Cell
            end
        end, Row)
    end, Matrix).

is_affected(R_curr, C_curr, FlipR, FlipC, R_max, C_max) ->
    (R_curr == FlipR and C_curr == FlipC) orelse
    (R_curr == FlipR - 1 and C_curr == FlipC and FlipR - 1 >= 0) orelse
    (R_curr == FlipR + 1 and C_curr == FlipC and FlipR + 1 < R_max) orelse
    (R_curr == FlipR and C_curr == FlipC - 1 and FlipC - 1 >= 0) orelse
    (R_curr == FlipR and C_curr == FlipC + 1 and FlipC + 1 < C_max).