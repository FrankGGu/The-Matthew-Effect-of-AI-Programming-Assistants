-module(solution).
-export([maxTotalFruits/3]).

-include_lib("kernel/include/array.hrl").

maxTotalFruits(Fruits, StartPos, K) ->
    SortedFruits = lists:sort(fun({P1, _}, {P2, _}) -> P1 =< P2 end, Fruits),
    N = length(SortedFruits),

    SortedFruitsArray = array:from_list(SortedFruits),

    % PrefixSums[i] stores the sum of fruits from index 0 to i-1
    % PrefixSumsArray will have N+1 elements, where PrefixSumsArray[0] = 0
    PrefixSumsList = lists:foldl(fun({_Pos, Amount}, Acc) ->
                                     Acc ++ [lists:last(Acc) + Amount]
                                 end, [0], SortedFruits),
    PrefixSumsArray = array:from_list(PrefixSumsList),

    % {LeftIdx, MaxSoFar}
    Result = lists:foldl(fun(RightIdx, {LeftIdx, MaxSoFar}) ->
                                 {RightPos, _} = array:get(RightIdx, SortedFruitsArray),

                                 % Adjust LeftIdx to find the smallest valid window ending at RightIdx
                                 AdjustedLeftIdx = adjust_left_ptr_loop(LeftIdx, RightIdx, RightPos, SortedFruitsArray, StartPos, K),

                                 CurrentFruits = get_sum_from_prefix(AdjustedLeftIdx, RightIdx, PrefixSumsArray),

                                 {AdjustedLeftIdx, max(MaxSoFar, CurrentFruits)}
                         end, {0, 0}, lists:seq(0, N-1)),

    element(2, Result).

calculate_steps(L, R, SP) ->
    if
        SP < L -> % StartPos is to the left of the window
            R - SP;
        SP > R -> % StartPos is to the right of the window
            SP - L;
        true -> % StartPos is within the window [L, R]
            % Option 1: Go left to L, then right to R
            Steps1 = (SP - L) + (R - L),
            % Option 2: Go right to R, then left to L
            Steps2 = (R - SP) + (R - L),
            min(Steps1, Steps2)
    end.

adjust_left_ptr_loop(LeftIdx, RightIdx, RightPos, SortedFruitsArray, StartPos, K) ->
    if
        LeftIdx > RightIdx -> % Window is empty or invalid
            LeftIdx;
        true ->
            {LeftPos, _} = array:get(LeftIdx, SortedFruitsArray),
            Steps = calculate_steps(LeftPos, RightPos, StartPos),
            if
                Steps > K ->
                    adjust_left_ptr_loop(LeftIdx + 1, RightIdx, RightPos, SortedFruitsArray, StartPos, K);
                true ->
                    LeftIdx
            end
    end.

get_sum_from_prefix(LeftIdx, RightIdx, PrefixSumsArray) ->
    if
        LeftIdx > RightIdx ->
            0;
        true ->
            array:get(RightIdx + 1, PrefixSumsArray) - array:get(LeftIdx, PrefixSumsArray)
    end.