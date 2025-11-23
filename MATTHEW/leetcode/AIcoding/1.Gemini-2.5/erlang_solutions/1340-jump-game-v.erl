-module(solution).
-export([max_jumps/2]).

max_jumps(ArrList, D) ->
    Arr = array:from_list(ArrList),
    N = array:size(Arr),
    InitialMemo = #{},
    compute_all_and_find_max(0, N, Arr, D, InitialMemo, 0).

compute_all_and_find_max(N, N, _Arr, _D, _Memo, MaxSoFar) ->
    MaxSoFar;
compute_all_and_find_max(I, N, Arr, D, Memo, MaxSoFar) ->
    {CurrentDP, NewMemo} = solve(I, N, Arr, D, Memo),
    compute_all_and_find_max(I + 1, N, Arr, D, NewMemo, max(MaxSoFar, CurrentDP)).

solve(I, N, Arr, D, Memo) ->
    case maps:find(I, Memo) of
        {ok, Val} ->
            {Val, Memo};
        error ->
            ValI = array:get(I, Arr),
            CurrentMaxJumps = 1,

            LeftBound = max(0, I - D),
            {MaxJumpsAfterLeft, Memo1} =
                check_jumps_direction(I - 1, LeftBound, -1, I, ValI, N, Arr, D, Memo, CurrentMaxJumps),

            RightBound = min(N - 1, I + D),
            {FinalMaxJumps, Memo2} =
                check_jumps_direction(I + 1, RightBound, 1, I, ValI, N, Arr, D, Memo1, MaxJumpsAfterLeft),

            {FinalMaxJumps, maps:put(I, FinalMaxJumps, Memo2)}
    end.

check_jumps_direction(J, EndJ, Step, I, ValI, N, Arr, D, Memo, AccMax) when J * Step > EndJ * Step ->
    {AccMax, Memo};
check_jumps_direction(J, EndJ, Step, I, ValI, N, Arr, D, Memo, AccMax) ->
    ValJ = array:get(J, Arr),
    if
        ValI > ValJ ->
            {DP_J, Memo1} = solve(J, N, Arr, D, Memo),
            NewAccMax = max(AccMax, 1 + DP_J),
            check_jumps_direction(J + Step, EndJ, Step, I, ValI, N, Arr, D, Memo1, NewAccMax);
        true ->
            {AccMax, Memo}
    end.