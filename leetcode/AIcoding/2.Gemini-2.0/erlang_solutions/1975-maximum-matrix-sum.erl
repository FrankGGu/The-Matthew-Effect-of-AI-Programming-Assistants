-module(maximum_matrix_sum).
-export([maximum_matrix_sum/1]).

maximum_matrix_sum(Matrix) ->
    {Negatives, Sum} = lists:foldl(
        fun(Row, {NegativesAcc, SumAcc}) ->
            lists:foldl(
                fun(Num, {NegativesAcc2, SumAcc2}) ->
                    if
                        Num < 0 ->
                            {NegativesAcc2 + 1, SumAcc2 + abs(Num)};
                        true ->
                            {NegativesAcc2, SumAcc2 + abs(Num)}
                    end
                end,
                {NegativesAcc, SumAcc},
                Row
            )
        end,
        {0, 0},
        Matrix
    ),
    if
        Negatives rem 2 == 0 ->
            Sum;
        true ->
            MinAbs = lists:min([abs(X) || Row <- Matrix, X <- Row]),
            Sum - 2 * MinAbs
    end.