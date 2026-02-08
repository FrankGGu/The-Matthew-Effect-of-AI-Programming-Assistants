-module(solution).
-export([modify_matrix/1]).

transpose([]) -> [];
transpose([[]|_]) -> [];
transpose(Matrix) ->
    [ [H || [H| _] <- Matrix] | transpose([T || [_|T] <- Matrix]) ].

modify_matrix(Matrix) ->
    TransposedMatrix = transpose(Matrix),

    ColMaxes = lists:map(
        fun(Col) ->
            lists:foldl(
                fun(Val, Acc) ->
                    if Val == -1 -> Acc;
                       true -> max(Val, Acc)
                    end
                end,
                0,
                Col
            )
        end,
        TransposedMatrix
    ),

    lists:mapi(
        fun(_I, Row) ->
            lists:mapi(
                fun(J, Val) ->
                    if Val == -1 ->
                        lists:nth(J + 1, ColMaxes);
                       true ->
                        Val
                    end
                end,
                Row
            )
        end,
        Matrix
    ).