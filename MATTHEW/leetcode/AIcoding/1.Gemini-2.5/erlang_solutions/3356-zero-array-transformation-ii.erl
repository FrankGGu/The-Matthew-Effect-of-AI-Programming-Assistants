-module(solution).
-export([min_cost_to_make_array_equal/3]).

min_cost_to_make_array_equal(Nums, Cost1, Cost2) ->
    N = length(Nums),

    % dp[i] will store the minimum cost to make nums[0...i-1] all zeros.
    % dp array is 0-indexed, so dp[0] to dp[N].
    % dp[0] = 0 (cost to make an empty prefix zero).
    Dp = array:new([{size, N + 1}, {fixed, true}, {default, infinity}]),
    Dp1 = array:set(0, 0, Dp),

    % k_val[idx] stores the starting index of the block of identical
    % non-zero values that ends at Nums[idx].
    % Nums is 0-indexed, so k_val will be 0-indexed from 0 to N-1.
    KVal = array:new([{size, N}, {fixed, true}, {default, 0}]),
    KVal1 = precompute_k_val(Nums, N, KVal),

    % Deques map: stores value -> queue:queue({Index, DpValue})
    % Each queue maintains (Index, DpValue) pairs in increasing order of DpValue.
    % Index is 'j' from dp[j], DpValue is dp[j].
    Deques = maps:new(),

    % Main DP loop
    % i represents the current length of the prefix being considered (nums[0...i-1])
    % and also the index for dp[i].
    ResultDp = dp_loop(0, N, Nums, Cost1, Cost2, Dp1, KVal1, Deques),

    array:get(N, ResultDp).

precompute_k_val(Nums, N, KVal) ->
    if N == 0 ->
        KVal;
    true ->
        KVal1 = array:set(0, 0, KVal),
        lists:foldl(
            fun(Idx, AccKVal) ->
                PrevVal = lists:nth(Idx, Nums), % Nums is 1-indexed in lists:nth
                CurrentVal = lists:nth(Idx + 1, Nums),
                if CurrentVal == PrevVal ->
                    array:set(Idx, array:get(Idx - 1, AccKVal), AccKVal);
                true ->
                    array:set(Idx, Idx, AccKVal)
                end
            end,
            KVal1,
            lists:seq(1, N - 1)
        )
    end.

dp_loop(I, N, Nums, Cost1, Cost2, Dp, KVal, Deques) ->
    if I > N ->
        Dp;
    true ->
        CurrentDp = if I > 0 ->
                        array:get(I - 1, Dp) + Cost1;
                    true ->
                        0 % dp[0] is 0
                    end,
        Dp2 = array:set(I, CurrentDp, Dp),

        {UpdatedDp, UpdatedDeques} = 
            if I > 0 ->
                ValAtIMinus1 = lists:nth(I, Nums), % Nums is 1-indexed, so Nums[I-1] is lists:nth(I, Nums)
                if ValAtIMinus1 /= 0 ->
                    L = array:get(I - 1, KVal), % k_val is 0-indexed, so k_val[I-1]
                    QVal = maps:get(ValAtIMinus1, Deques, queue:new()),

                    % Remove elements from front of QVal whose indices are less than L
                    QValCleaned = remove_old_elements(QVal, L),

                    Option2Cost = if not queue:is_empty(QValCleaned) ->
                                    {_JMin, DpJMin} = queue:head(QValCleaned),
                                    DpJMin + Cost2;
                                true ->
                                    infinity
                                end,

                    NewDpI = min(array:get(I, Dp2), Option2Cost),
                    Dp3 = array:set(I, NewDpI, Dp2),

                    % Add (I, NewDpI) to QValCleaned while maintaining monotonicity
                    QValToAdd = add_to_deque(QValCleaned, {I, NewDpI}),
                    NewDeques = maps:put(ValAtIMinus1, QValToAdd, Deques),
                    {Dp3, NewDeques};
                true ->
                    {Dp2, Deques} % ValAtIMinus1 is 0, no Option 2 ending here
                end;
            true ->
                {Dp2, Deques} % I is 0, no Option 2
            end,

        % Add (I, dp[I]) to the deque for nums[I] if I is a valid starting point for a block of nums[I]s.
        FinalDeques = 
            if I < N andalso lists:nth(I + 1, Nums) /= 0 andalso (I == 0 orelse lists:nth(I, Nums) /= lists:nth(I + 1, Nums)) ->
                ValAtI = lists:nth(I + 1, Nums), % Nums[I] is lists:nth(I+1, Nums)
                QValAtI = maps:get(ValAtI, UpdatedDeques, queue:new()),
                QValAtIUpdated = add_to_deque(QValAtI, {I, array:get(I, UpdatedDp)}),
                maps:put(ValAtI, QValAtIUpdated, UpdatedDeques);
            true ->
                UpdatedDeques
            end,

        dp_loop(I + 1, N, Nums, Cost1, Cost2, UpdatedDp, KVal, FinalDeques)
    end.

remove_old_elements(Q, L) ->
    if not queue:is_empty(Q) andalso element(1, queue:head(Q)) < L ->
        remove_old_elements(queue:tail(Q), L);
    true ->
        Q
    end.

add_to_deque(Q, {Index, DpValue}) ->
    Q1 = remove_larger_or_equal_elements(Q, DpValue),
    queue:in_q_tail({Index, DpValue}, Q1).

remove_larger_or_equal_elements(Q, DpValue) ->
    if not queue:is_empty(Q) andalso element(2, queue:last(Q)) >= DpValue ->
        remove_larger_or_equal_elements(queue:de_q_tail(Q), DpValue);
    true ->
        Q
    end.