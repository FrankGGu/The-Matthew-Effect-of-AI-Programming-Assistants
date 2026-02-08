-module(solution).
-export([waysToSplit/1]).

waysToSplit(Nums) ->
    N = length(Nums),
    PrefixSumsTuple = calculate_prefix_sums(Nums),
    TotalSum = element(N + 1, PrefixSumsTuple),

    count_ways(0, N, PrefixSumsTuple, TotalSum, 1, 1, 0).

calculate_prefix_sums(Nums) ->
    calculate_prefix_sums_acc(Nums, 0, [0]).

calculate_prefix_sums_acc([], _, Acc) ->
    list_to_tuple(lists:reverse(Acc));
calculate_prefix_sums_acc([H|T], CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    calculate_prefix_sums_acc(T, NewSum, [NewSum | Acc]).

count_ways(I, N, PrefixSums, TotalSum, J_ptr, K_ptr, Count) ->
    % I is the 0-indexed end of the left subarray.
    % Left subarray is Nums[0...I].
    % Mid subarray is Nums[I+1...J].
    % Right subarray is Nums[J+1...N-1].
    % Constraints:
    % I must be <= N-3 (to allow for non-empty mid and right)
    % J must be >= I+1 (mid non-empty)
    % J must be <= N-2 (right non-empty)

    if
        I > N - 3 ->
            Count;
        true ->
            % S1 = sum(Nums[0...I]) = PrefixSums[I+1]
            % PrefixSums tuple is 1-indexed, P[k] is element(k+1, tuple)
            S1 = element(I + 2, PrefixSums), 

            % Advance J_ptr (lower bound for J)
            % J_ptr must be at least I+1 for mid to be non-empty
            J_current = max(J_ptr, I + 1),
            J_new = advance_j_pointer(J_current, N, PrefixSums, S1),

            if
                J_new > N - 2 ->
                    Count;
                true ->
                    % Advance K_ptr (upper bound for J)
                    % K_ptr must be at least J_new
                    K_current = max(K_ptr, J_new),
                    K_new = advance_k_pointer(K_current, N, PrefixSums, TotalSum, S1),

                    % The number of valid J for this I is K_new - J_new
                    NewCount = Count + (K_new - J_new),
                    count_ways(I + 1, N, PrefixSums, TotalSum, J_new, K_new, NewCount)
            end
    end.

advance_j_pointer(J_val, N, PrefixSums, S1) ->
    % Condition for J: sum(left) <= sum(mid) => S1 <= P[J+1] - S1 => 2 * S1 <= P[J+1]
    % P[J+1] is element(J_val+2, PrefixSums)
    % J_val must be <= N-2
    if
        J_val > N - 2 ->
            J_val;
        element(J_val + 2, PrefixSums) < 2 * S1 ->
            advance_j_pointer(J_val + 1, N, PrefixSums, S1);
        true ->
            J_val
    end.

advance_k_pointer(K_val, N, PrefixSums, TotalSum, S1) ->
    % Condition for K: sum(mid) <= sum(right) => P[K+1] - S1 <= TotalSum - P[K+1] => 2 * P[K+1] <= TotalSum + S1
    % P[K+1] is element(K_val+2, PrefixSums)
    % K_val must be <= N-2
    if
        K_val > N - 2 ->
            K_val;
        element(K_val + 2, PrefixSums) <= (TotalSum + S1) div 2 ->
            advance_k_pointer(K_val + 1, N, PrefixSums, TotalSum, S1);
        true ->
            K_val
    end.