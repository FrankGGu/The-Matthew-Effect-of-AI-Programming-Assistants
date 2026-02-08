-module(solution).
-export([num_moves_stones_until_consecutive_ii/1]).

num_moves_stones_until_consecutive_ii(Stones) ->
    SortedStones = lists:sort(Stones),
    N = length(SortedStones),
    MinMoves = calculate_min_moves(SortedStones, N),
    MaxMoves = calculate_max_moves(SortedStones, N),
    [MinMoves, MaxMoves].

calculate_min_moves(SortedStones, N) ->
    calculate_min_moves_recursive(SortedStones, N, 1, 1, N).

calculate_min_moves_recursive(SortedStones, N, I, J, MinMovesAcc) when J =< N ->
    CurrentS_J = lists:nth(J, SortedStones),

    {NewI, NewS_I} = adjust_i(SortedStones, N, I, J, CurrentS_J),

    Count = J - NewI + 1,
    CurrentSpan = CurrentS_J - NewS_I + 1,

    NewMinMovesAcc =
        if
            Count == N - 1 andalso CurrentSpan == N ->
                min(MinMovesAcc, 1);
            true ->
                min(MinMovesAcc, N - Count)
        end,
    calculate_min_moves_recursive(SortedStones, N, NewI, J + 1, NewMinMovesAcc);
calculate_min_moves_recursive(_SortedStones, _N, _I, _J, MinMovesAcc) ->
    MinMovesAcc.

adjust_i(SortedStones, N, I_current, J, CurrentS_J) ->
    S_I_current = lists:nth(I_current, SortedStones),
    if
        CurrentS_J - S_I_current + 1 > N ->
            adjust_i(SortedStones, N, I_current + 1, J, CurrentS_J);
        true ->
            {I_current, S_I_current}
    end.

calculate_max_moves(SortedStones, N) ->
    S_0 = lists:nth(1, SortedStones),
    S_N_minus_1 = lists:nth(N, SortedStones),
    S_1 = lists:nth(2, SortedStones),
    S_N_minus_2 = lists:nth(N-1, SortedStones),

    Max1 = S_N_minus_1 - S_1 - (N - 2),
    Max2 = S_N_minus_2 - S_0 - (N - 2),
    max(Max1, Max2).