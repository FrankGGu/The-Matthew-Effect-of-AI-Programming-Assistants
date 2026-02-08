-module(solution).
-export([deliver_boxes/4]).

deliver_boxes(Boxes, _Ports, MaxBoxes, MaxWeight) ->
    N = length(Boxes),

    % Extract Ports and Weights
    {P_arr_list, W_arr_list} = lists:unzip(Boxes),
    P_arr = array:from_list(P_arr_list),
    W_arr = array:from_list(W_arr_list),

    % prefix_weights: prefix_weights[k] is sum of W_arr[0...k-1]
    % Size N+1. Index 0 to N.
    % prefix_weights[0] = 0
    % prefix_weights[k] = sum(W_arr[0...k-1])
    PrefixWeights = array:new([{size, N + 1}, {default, 0}]),
    PrefixWeights1 = lists:foldl(
        fun(K, Acc) ->
            Weight_k_minus_1 = array:get(K-1, W_arr),
            PrevSum = array:get(K-1, Acc),
            array:set(K, PrevSum + Weight_k_minus_1, Acc)
        end,
        PrefixWeights,
        lists:seq(1, N)
    ),

    % prefix_port_change_sum: prefix_port_change_sum[k] is count of changes in P_arr[0...k-1]
    % Size N+2. Index 0 to N+1.
    % prefix_port_change_sum[0] = 0
    % prefix_port_change_sum[1] = 0 (no P_arr[-1] to compare P_arr[0] with)
    % prefix_port_change_sum[k] = sum(1 for x from 1 to k-1 if P_arr[x] =/= P_arr[x-1])
    PrefixPortChangeSum = array:new([{size, N + 2}, {default, 0}]),
    PrefixPortChangeSum1 = lists:foldl(
        fun(K, Acc) ->
            IsChange = if
                K > 1 andalso array:get(K-1, P_arr) =/= array:get(K-2, P_arr) -> 1;
                true -> 0
            end,
            PrevSum = array:get(K-1, Acc),
            array:set(K, PrevSum + IsChange, Acc)
        end,
        PrefixPortChangeSum,
        lists:seq(1, N)
    ),
    % Set prefix_port_change_sum[N+1] for the g(N) case
    PrefixPortChangeSum2 = array:set(N+1, array:get(N, PrefixPortChangeSum1), PrefixPortChangeSum1),

    % dp array
    % Size N+1. Index 0 to N.
    % dp[0] = 0, others infinity
    DP = array:new([{size, N + 1}, {default, float:infinity}]),
    DP1 = array:set(0, 0, DP),

    % Deque (queue)
    Q = queue:from_list([0]), % Stores indices j

    LeftBoxIdx = 0, % Leftmost valid index for the current window [LeftBoxIdx, I-1]
    CurrentWindowWeight = 0,

    % Loop for I from 1 to N (I represents the end of the segment, boxes[0...I-1])
    lists:foldl(
        fun(I, {CurrentDP, CurrentQ, CurrentLeftBoxIdx, CurrentWindowWeightAcc}) ->
            Weight_i_minus_1 = array:get(I-1, W_arr),
            NewCurrentWindowWeightAcc = CurrentWindowWeightAcc + Weight_i_minus_1,

            % Adjust LeftBoxIdx based on MaxBoxes and MaxWeight
            {NewLeftBoxIdx, FinalWindowWeightAcc} = 
                adjust_left_box_idx(I, MaxBoxes, MaxWeight, CurrentLeftBoxIdx, NewCurrentWindowWeightAcc, W_arr),

            % Remove indices from front of Q that are no longer valid (j < NewLeftBoxIdx)
            PrunedQ = prune_q_front(CurrentQ, NewLeftBoxIdx),

            % Calculate dp[I]
            Q_front_idx = queue:head(PrunedQ),

            % dp[I] = (1 + prefix_port_change_sum[I]) + (dp[Q.front()] - prefix_port_change_sum[Q.front()+1])
            Term1 = 1 + array:get(I, PrefixPortChangeSum2),
            Term2 = array:get(Q_front_idx, CurrentDP) - array:get(Q_front_idx + 1, PrefixPortChangeSum2),

            DP_I = Term1 + Term2,
            NewDP = array:set(I, DP_I, CurrentDP),

            % Add I to Q, maintaining monotonic property
            % The value to compare is dp[j] - prefix_port_change_sum[j+1]
            ValToAddToQ = DP_I - array:get(I + 1, PrefixPortChangeSum2),
            NewQ = prune_q_back_and_add(PrunedQ, I, ValToAddToQ, NewDP, PrefixPortChangeSum2),

            {NewDP, NewQ, NewLeftBoxIdx, FinalWindowWeightAcc}
        end,
        {DP1, Q, LeftBoxIdx, CurrentWindowWeight},
        lists:seq(1, N)
    )
    -> {FinalDP, _, _, _},
    array:get(N, FinalDP).

adjust_left_box_idx(I, MaxBoxes, MaxWeight, LeftBoxIdx, CurrentWindowWeightAcc, W_arr) ->
    adjust_left_box_idx_loop(I, MaxBoxes, MaxWeight, LeftBoxIdx, CurrentWindowWeightAcc, W_arr).

adjust_left_box_idx_loop(I, MaxBoxes, MaxWeight, LeftBoxIdx, CurrentWindowWeightAcc, W_arr) ->
    if
        I - LeftBoxIdx > MaxBoxes orelse CurrentWindowWeightAcc > MaxWeight ->
            Weight_LeftBoxIdx = array:get(LeftBoxIdx, W_arr),
            adjust_left_box_idx_loop(I, MaxBoxes, MaxWeight, LeftBoxIdx + 1, CurrentWindowWeightAcc - Weight_LeftBoxIdx, W_arr);
        true ->
            {LeftBoxIdx, CurrentWindowWeightAcc}
    end.

prune_q_front(Q, LeftBoxIdx) ->
    if
        queue:is_empty(Q) -> Q;
        queue:head(Q) < LeftBoxIdx -> prune_q_front(queue:tail(Q), LeftBoxIdx);
        true -> Q
    end.

prune_q_back_and_add(Q, I, ValToAddToQ, DP, PrefixPortChangeSum) ->
    prune_q_back_and_add_loop(Q, I, ValToAddToQ, DP, PrefixPortChangeSum).

prune_q_back_and_add_loop(Q, I, ValToAddToQ, DP, PrefixPortChangeSum) ->
    if
        queue:is_empty(Q) -> queue:in(I, Q);
        (array:get(queue:last(Q), DP) - array:get(queue:last(Q) + 1, PrefixPortChangeSum)) >= ValToAddToQ ->
            prune_q_back_and_add_loop(queue:init(Q), I, ValToAddToQ, DP, PrefixPortChangeSum);
        true ->
            queue:in(I, Q)
    end.