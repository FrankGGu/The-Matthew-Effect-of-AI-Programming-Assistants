-module(solution).
-export([min_falling_path_sum/1]).

min_falling_path_sum(Matrix) ->
    N = length(Matrix),
    case N of
        0 -> 0;
        1 -> lists:min(hd(Matrix));
        _ ->
            [FirstRow | RestOfMatrix] = Matrix,
            Inf = 1000000000,

            FinalDPRow = lists:foldl(
                fun(CurrentMatrixRow, PrevDPRow) ->
                    calculate_next_dp_row(CurrentMatrixRow, PrevDPRow, Inf)
                end,
                FirstRow,
                RestOfMatrix
            ),
            lists:min(FinalDPRow)
    end.

calculate_next_dp_row(CurrentMatrixRow, PrevDPRow, Inf) ->
    P_Left_aligned = [Inf | lists:droplast(PrevDPRow)],
    P_Center_aligned = PrevDPRow,
    P_Right_aligned = lists:tl(PrevDPRow) ++ [Inf],

    lists:map(
        fun({M_Val, {PL, PC, PR}}) ->
            M_Val + lists:min([PL, PC, PR])
        end,
        lists:zip(CurrentMatrixRow, lists:zip3(P_Left_aligned, P_Center_aligned, P_Right_aligned))
    ).