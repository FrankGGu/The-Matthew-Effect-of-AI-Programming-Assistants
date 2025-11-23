-module(pacific_atlantic).
-export([pacific_atlantic/1]).

pacific_atlantic(Heights) ->
    Rows = length(Heights),
    Cols = length(lists:nth(1, Heights)),
    Pacific = create_matrix(Rows, Cols, false),
    Atlantic = create_matrix(Rows, Cols, false),

    {PacificUpdated, AtlanticUpdated} =
        lists:foldl(
            fun(I, {P, A}) ->
                {flood_fill(Heights, I, 0, P, I, 0, []),
                 flood_fill(Heights, I, Cols - 1, A, I, Cols - 1, [])}
            end,
            {Pacific, Atlantic},
            lists:seq(0, Rows - 1)
        ),

    {PacificUpdated2, AtlanticUpdated2} =
        lists:foldl(
            fun(J, {P, A}) ->
                {flood_fill(Heights, 0, J, P, 0, J, []),
                 flood_fill(Heights, Rows - 1, J, A, Rows - 1, J, [])}
            end,
            {PacificUpdated, AtlanticUpdated},
            lists:seq(0, Cols - 1)
        ),

    Result = lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, Acc2) ->
                    if
                        matrix_get(PacificUpdated2, I, J) andalso matrix_get(AtlanticUpdated2, I, J) ->
                            [{I, J} | Acc2];
                        true ->
                            Acc2
                    end
                end,
                Acc,
                lists:seq(0, Cols - 1)
            )
        end,
        [],
        lists:seq(0, Rows - 1)
    ),
    Result.

flood_fill(Heights, Row, Col, Matrix, I, J, Visited) ->
    Rows = length(Heights),
    Cols = length(lists:nth(1, Heights)),

    if
        Row < 0 orelse Row >= Rows orelse Col < 0 orelse Col >= Cols orelse
        lists:member({Row, Col}, Visited) orelse
        (I /= Row orelse J /= Col) andalso matrix_get_height(Heights, Row, Col) < matrix_get_height(Heights, I, J) ->
        Matrix;
    true ->
        NewMatrix = matrix_set(Matrix, Row, Col, true),
        flood_fill(Heights, Row + 1, Col, NewMatrix, Row, Col, [{Row, Col} | Visited]),
        flood_fill(Heights, Row - 1, Col, NewMatrix, Row, Col, [{Row, Col} | Visited]),
        flood_fill(Heights, Row, Col + 1, NewMatrix, Row, Col, [{Row, Col} | Visited]),
        flood_fill(Heights, Row, Col - 1, NewMatrix, Row, Col, [{Row, Col} | Visited])
    end.

create_matrix(Rows, Cols, Value) ->
    lists:map(fun(_) -> lists:duplicate(Cols, Value) end, lists:seq(1, Rows)).

matrix_get(Matrix, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Matrix)).

matrix_set(Matrix, Row, Col, Value) ->
    lists:nth(Row + 1, lists:map(
        fun(R, Index) ->
            if Index == Row + 1 then
                lists:nth(Col + 1, lists:map(
                    fun(C, Index2) ->
                        if Index2 == Col + 1 then
                            Value
                        else
                            C
                        end
                    end,
                    R,
                    lists:seq(1, length(R))
                ))
            else
                R
            end
        end,
        Matrix,
        lists:seq(1, length(Matrix))
    )).

matrix_get_height(Heights, Row, Col) ->
    lists:nth(Col + 1, lists:nth(Row + 1, Heights)).