-module(solution).
-export([maximal_square/1]).

maximal_square(Matrix) ->
    M = length(Matrix),
    case M of
        0 -> 0;
        _ ->
            N = length(hd(Matrix)),
            case N of
                0 -> 0;
                _ ->
                    MatrixArray = gb_array:from_list(lists:map(fun(Row) -> gb_array:from_list(Row) end, Matrix)),
                    DP_initial = gb_array:new([{size, M*N}, {default, 0}]),
                    {_FinalDP, MaxSide} = maximal_square_dp_loop(MatrixArray, M, N, DP_initial, 0, 0, 0),
                    MaxSide * MaxSide
            end
    end.

maximal_square_dp_loop(MatrixArray, M, N, DP, I, J, CurrentMaxSide) ->
    if
        I >= M -> {DP, CurrentMaxSide};
        J >= N -> maximal_square_dp_loop(MatrixArray, M, N, DP, I + 1, 0, CurrentMaxSide);
        true ->
            Val = gb_array:get(J, gb_array:get(I, MatrixArray)),
            Index = I * N + J,

            if
                Val == $1 ->
                    CalculatedVal = 0,
                    if
                        I == 0; J == 0 ->
                            CalculatedVal = 1;
                        true ->
                            PrevUp = gb_array:get((I - 1) * N + J, DP),
                            PrevLeft = gb_array:get(I * N + (J - 1), DP),
                            PrevDiag = gb_array:get((I - 1) * N + (J - 1), DP),
                            CalculatedVal = 1 + min_three(PrevUp, PrevLeft, PrevDiag)
                    end,
                    NewDP = gb_array:set(Index, CalculatedVal, DP),
                    NewMaxSide = max(CurrentMaxSide, CalculatedVal),
                    maximal_square_dp_loop(MatrixArray, M, N, NewDP, I, J + 1, NewMaxSide);
                true ->
                    NewDP = gb_array:set(Index, 0, DP),
                    NewMaxSide = CurrentMaxSide,
                    maximal_square_dp_loop(MatrixArray, M, N, NewDP, I, J + 1, NewMaxSide)
            end
    end.

min_three(A, B, C) ->
    min(A, min(B, C)).