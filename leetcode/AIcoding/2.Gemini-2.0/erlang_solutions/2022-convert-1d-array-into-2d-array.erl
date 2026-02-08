-module(solution).
-export([construct2DArray/3]).

construct2DArray(Original, M, N) ->
    Len = length(Original),
    if Len =/= M * N then
        []
    else
        lists:foldl(
            fun(I, Acc) ->
                RowIndex = (I - 1) div N,
                ColIndex = (I - 1) rem N,
                Val = lists:nth(I, Original),
                update_matrix(Acc, RowIndex, ColIndex, Val)
            end,
            create_matrix(M, N),
            lists:seq(1, Len)
        )
    end.

create_matrix(M, N) ->
    lists:map(fun(_) -> lists:duplicate(N, 0) end, lists:seq(1, M)).

update_matrix(Matrix, RowIndex, ColIndex, Val) ->
    lists:map(
        fun(Row, Index) ->
            if Index =:= RowIndex + 1 then
                lists:map(
                    fun(Col, ColIndex2) ->
                        if ColIndex2 =:= ColIndex + 1 then
                            Val
                        else
                            Col
                        end
                    end,
                    Row,
                    lists:seq(1, length(Row))
                )
            else
                Row
            end
        end,
        Matrix,
        lists:seq(1, length(Matrix))
    ).