-module(solution).
-export([minimum_cost/3]).

minimum_cost(Nums, K, MinLength) ->
    N = length(Nums),
    Cost0 = hd(Nums),
    MaxVal = float:infinity(),

    % Handle K = 1 case
    % If K=1, there's only one subarray, which starts at index 0.
    % No other subarrays, so no min_length constraint applies.
    % Cost is just nums[0].
    if K == 1 ->
        Cost0;
    true ->
        % Convert Nums list to an array for O(1) access
        NumsArr = array:from_list(Nums),

        % Handle MinLength = 1 case
        % If MinLength = 1, we just need to pick K-1 distinct indices p_1, ..., p_{K-1}
        % from 1 to N-1 (inclusive) to minimize sum(nums[p_i]).
        % The constraint n - p_{K-1} >= 1 means p_{K-1} <= N-1, which is always true
        % for indices in 1 to N-1.
        % So, pick the K-1 smallest values from Nums[1...N-1].
        if MinLength == 1 ->
            % Extract elements from NumsArr[1] to NumsArr[N-1]
            Candidates = array:to_list(array:sub(1, N - 1, NumsArr)),
            SortedCandidates = lists:sort(Candidates),
            % Take the K-1 smallest elements
            SmallestKMinus1 = lists:sublist(SortedCandidates, K - 1),
            SumSmallest = lists:sum(SmallestKMinus1),
            Cost0 + SumSmallest;
        true ->
            % General case: MinLength > 1
            % DP approach: dp[j][i] = min cost to select j elements, with nums[i] being the j-th element.
            % We use two arrays (PrevDp, CurrDp) to optimize space.
            % PrevDp stores dp[j-1] values, CurrDp stores dp[j] values.
            PrevDp = array:new({size, N}, MaxVal),
            CurrDp = array:new({size, N}, MaxVal),

            % Initialize PrevDp for J=1 (first chosen point p_1)
            % p_1 can be from 1 to N - (K-1)*MinLength.
            P1MaxIdx = N - (K - 1) * MinLength,

            % If P1MaxIdx < 1, it's impossible to place K-1 elements with min_length gap.
            % This implies that K is too large for the given N and MinLength.
            % The problem constraints should prevent this for valid test cases,
            % but we return MaxVal as an impossible cost.
            if P1MaxIdx < 1 ->
                MaxVal;
            true ->
                % Fill PrevDp for J=1
                % p_1 is the first chosen index, it can be from 1 to P1MaxIdx
                % Cost is just NumsArr[Idx]
                PrevDp1 = fill_dp_for_j1(1, P1MaxIdx, NumsArr, PrevDp),

                % Loop J from 2 to K-1 (K-1 is the number of additional points to pick)
                FinalPrevDp = lists:foldl(
                    fun(J, AccPrevDp) ->
                        compute_curr_dp(J, K, N, MinLength, NumsArr, AccPrevDp, MaxVal)
                    end,
                    PrevDp1,
                    lists:seq(2, K - 1)
                ),

                % After the loop, FinalPrevDp contains dp[K-1] values.
                % Find the minimum in FinalPrevDp for indices from
                % 1 + (K-2)*MinLength to N - MinLength.
                MinFinalIdx = 1 + (K - 2) * MinLength,
                MaxFinalIdx = N - MinLength,

                MinCostForChosenPoints = find_min_in_range(MinFinalIdx, MaxFinalIdx, FinalPrevDp, MaxVal),

                if MinCostForChosenPoints == MaxVal ->
                    MaxVal; % No valid division found
                true ->
                    Cost0 + MinCostForChosenPoints
                end
            end
        end
    end.

fill_dp_for_j1(Idx, MaxIdx, NumsArr, CurrentDp) when Idx =< MaxIdx ->
    Val = array:get(Idx, NumsArr),
    UpdatedDp = array:set(Idx, Val, CurrentDp),
    fill_dp_for_j1(Idx + 1, MaxIdx, NumsArr, UpdatedDp);
fill_dp_for_j1(_Idx, _MaxIdx, _NumsArr, CurrentDp) ->
    CurrentDp.

compute_curr_dp(J, K, N, MinLength, NumsArr, PrevDp, MaxVal) ->
    CurrDp = array:new({size, N}, MaxVal),
    Deque = queue:new(),

    MinIdxForPrevJ = 1 + (J - 2) * MinLength,
    MaxIdxForPrevJ = N - (K - J) * MinLength,
    MinIdxForCurrJ = 1 + (J - 1) * MinLength,
    MaxIdxForCurrJ = N - (K - J) * MinLength,

    % PrevIdxForDequeAdd tracks the index from PrevDp to potentially add to the deque
    PrevIdxForDequeAdd = MinIdxForPrevJ,

    compute_curr_dp_loop(MinIdxForCurrJ, MaxIdxForCurrJ, PrevIdxForDequeAdd,
                         MinIdxForPrevJ, MaxIdxForPrevJ,
                         MinLength, NumsArr, PrevDp, CurrDp, Deque, MaxVal).

compute_curr_dp_loop(I, MaxIdxForCurrJ, PrevIdxForDequeAdd,
                     MinIdxForPrevJ, MaxIdxForPrevJ,
                     MinLength, NumsArr, PrevDp, CurrDp, Deque, MaxVal)
                     when I =< MaxIdxForCurrJ ->
    % Add relevant PrevDp values to deque
    {UpdatedDeque1, NextPrevIdxForDequeAdd} = add_to_deque_loop(
        PrevIdxForDequeAdd, I - MinLength, MaxIdxForPrevJ, PrevDp, Deque, MaxVal
    ),

    % Remove elements from deque that are too old (their index is less than I - MinLength)
    UpdatedDeque2 = remove_from_deque_loop(UpdatedDeque1, I - MinLength),

    % Calculate CurrDp[I]
    UpdatedCurrDp = if not queue:is_empty(UpdatedDeque2) ->
                        {MinPrevVal, _} = queue:head(UpdatedDeque2),
                        array:set(I, array:get(I, NumsArr) + MinPrevVal, CurrDp);
                    true ->
                        array:set(I, MaxVal, CurrDp) % No valid previous choice
                    end,

    compute_curr_dp_loop(I + 1, MaxIdxForCurrJ, NextPrevIdxForDequeAdd,
                         MinIdxForPrevJ, MaxIdxForPrevJ,
                         MinLength, NumsArr, PrevDp, UpdatedCurrDp, UpdatedDeque2, MaxVal);
compute_curr_dp_loop(_I, _MaxIdxForCurrJ, _PrevIdxForDequeAdd,
                     _MinIdxForPrevJ, _MaxIdxForPrevJ,
                     _MinLength, _NumsArr, _PrevDp, CurrDp, _Deque, _MaxVal) ->
    CurrDp.

add_to_deque_loop(CurrentPrevIdx, MaxPrevIdxInWindow, MaxIdxForPrevJ, PrevDp, Deque, MaxVal)
                   when CurrentPrevIdx =< MaxPrevIdxInWindow andalso CurrentPrevIdx =< MaxIdxForPrevJ ->
    Val = array:get(CurrentPrevIdx, PrevDp),
    NewDeque = if Val /= MaxVal ->
                   % Remove elements from back of deque that are greater than or equal to Val
                   CleanedDeque = remove_greater_or_equal_from_back(Deque, Val),
                   queue:in({Val, CurrentPrevIdx}, CleanedDeque);
               true ->
                   Deque
               end,
    add_to_deque_loop(CurrentPrevIdx + 1, MaxPrevIdxInWindow, MaxIdxForPrevJ, PrevDp, NewDeque, MaxVal);
add_to_deque_loop(CurrentPrevIdx, _MaxPrevIdxInWindow, _MaxIdxForPrevJ, _PrevDp, Deque, _MaxVal) ->
    {Deque, CurrentPrevIdx}.

remove_greater_or_equal_from_back(Deque, Val) ->
    if not queue:is_empty(Deque) andalso element(1, queue:last(Deque)) >= Val ->
        remove_greater_or_equal_from_back(queue:drop_last(Deque), Val);
    true ->
        Deque
    end.

remove_from_deque_loop(Deque, MinAllowedIdx) ->
    if not queue:is_empty(Deque) andalso element(2, queue:head(Deque)) < MinAllowedIdx ->
        remove_from_deque_loop(queue:drop_front(Deque), MinAllowedIdx);
    true ->
        Deque
    end.

find_min_in_range(Idx, MaxIdx, Arr, CurrentMin) when Idx =< MaxIdx ->
    Val = array:get(Idx, Arr),
    find_min_in_range(Idx + 1, MaxIdx, Arr, min(CurrentMin, Val));
find_min_in_range(_Idx, _MaxIdx, _Arr, CurrentMin) ->
    CurrentMin.