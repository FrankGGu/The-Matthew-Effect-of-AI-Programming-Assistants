-module(solution).
-export([min_swaps_to_make_sequences_increasing/2]).

min_swaps_to_make_sequences_increasing(A, B) ->
    [H_A | T_A] = A,
    [H_B | T_B] = B,

    solve(T_A, T_B, H_A, H_B, 0, 1).

solve([A_curr | T_A], [B_curr | T_B], A_prev, B_prev, DpNoSwapPrev, DpSwapPrev) ->
    Infinity = 1000000000,

    DpNoSwapCurr_from_NoSwapPrev =
        if A_curr > A_prev andalso B_curr > B_prev ->
            DpNoSwapPrev;
        true ->
            Infinity
        end,

    DpNoSwapCurr_from_SwapPrev =
        if A_curr > B_prev andalso B_curr > A_prev ->
            DpSwapPrev;
        true ->
            Infinity
        end,

    FinalDpNoSwapCurr = min(DpNoSwapCurr_from_NoSwapPrev, DpNoSwapCurr_from_SwapPrev),

    DpSwapCurr_from_NoSwapPrev =
        if B_curr > A_prev andalso A_curr > B_prev ->
            DpNoSwapPrev + 1;
        true ->
            Infinity
        end,

    DpSwapCurr_from_SwapPrev =
        if B_curr > B_prev andalso A_curr > A_prev ->
            DpSwapPrev + 1;
        true ->
            Infinity
        end,

    FinalDpSwapCurr = min(DpSwapCurr_from_NoSwapPrev, DpSwapCurr_from_SwapPrev),

    solve(T_A, T_B, A_curr, B_curr, FinalDpNoSwapCurr, FinalDpSwapCurr);

solve([], [], _A_prev, _B_prev, DpNoSwapPrev, DpSwapPrev) ->
    min(DpNoSwapPrev, DpSwapPrev).