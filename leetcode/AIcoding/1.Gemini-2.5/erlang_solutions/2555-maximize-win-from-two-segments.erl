-module(solution).
-export([maximize_win/2]).

maximize_win(Prizes, K) ->
    N = length(Prizes),
    if N == 0 -> 0;
       true ->
            PrizesArray = array:from_list(Prizes),
            MaxSingleSegmentVal = calculate_max_single_segment(PrizesArray, N, K),
            2 * MaxSingleSegmentVal
    end.

calculate_max_single_segment(PrizesArray, N, K) ->
    calculate_max_single_segment_loop(0, 0, 0, N, K, PrizesArray).

calculate_max_single_segment_loop(I, LeftPtr, CurrentMax, N, K, PrizesArray) ->
    if I == N ->
        CurrentMax;
    true ->
        PrizeI = array:get(I, PrizesArray),

        NewLeftPtr = adjust_left_ptr_iter(LeftPtr, I, K, PrizesArray, PrizeI),

        SegmentPrizes = I - NewLeftPtr + 1,

        NewCurrentMax = max(CurrentMax, SegmentPrizes),

        calculate_max_single_segment_loop(I + 1, NewLeftPtr, NewCurrentMax, N, K, PrizesArray)
    end.

adjust_left_ptr_iter(LeftPtr, _I, K, PrizesArray, PrizeI) ->
    PrizeLeftPtr = array:get(LeftPtr, PrizesArray),

    if PrizeI - PrizeLeftPtr > K - 1 ->
        adjust_left_ptr_iter(LeftPtr + 1, _I, K, PrizesArray, PrizeI);
    true ->
        LeftPtr
    end.