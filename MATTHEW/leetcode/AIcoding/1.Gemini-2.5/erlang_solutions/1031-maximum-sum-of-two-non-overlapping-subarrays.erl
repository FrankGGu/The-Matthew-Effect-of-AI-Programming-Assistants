-module(solution).
-export([max_sum_two_no_overlap/3]).

max_sum_two_no_overlap(A, FirstLen, SecondLen) ->
    N = length(A),
    if
        N < FirstLen + SecondLen -> 0;
        true ->
            PrefixSums = calculate_prefix_sums(A),

            MaxLeft1 = calculate_max_left(N, FirstLen, PrefixSums),
            MaxRight2 = calculate_max_right(N, SecondLen, PrefixSums),
            MaxSum12 = calculate_combined_max_sum(N, FirstLen, SecondLen, MaxLeft1, MaxRight2),

            MaxLeft2 = calculate_max_left(N, SecondLen, PrefixSums),
            MaxRight1 = calculate_max_right(N, FirstLen, PrefixSums),
            MaxSum21 = calculate_combined_max_sum(N, SecondLen, FirstLen, MaxLeft2, MaxRight1),

            max(MaxSum12, MaxSum21)
    end.

calculate_prefix_sums(Arr) ->
    lists:foldl(fun(X, Acc) -> Acc ++ [lists:last(Acc) + X] end, [0], Arr).

calculate_max_left(N, L, PrefixSums) ->
    lists:reverse(calculate_max_left_recursive(N, L, PrefixSums, 0, 0, [])).

calculate_max_left_recursive(N, L, PrefixSums, I, PrevMax, Acc) when I < N ->
    WindowSum = 0,
    CurrentMax = 0,
    if
        I < L - 1 ->
            CurrentMax = PrevMax;
        true ->
            % Sum of subarray A[I-L+1 ... I]
            % PrefixSums is 0-indexed: P[k] = sum(A[0...k-1])
            % Sum(A[start_idx ... end_idx]) = P[end_idx+1] - P[start_idx]
            % For window (I-L+1) to I:
            % P[I+1] - P[I-L+1]
            WindowSum = lists:nth(I + 1 + 1, PrefixSums) - lists:nth(I - L + 1 + 1, PrefixSums),
            CurrentMax = max(PrevMax, WindowSum)
    end,
    calculate_max_left_recursive(N, L, PrefixSums, I + 1, CurrentMax, [CurrentMax | Acc]);
calculate_max_left_recursive(_N, _L, _PrefixSums, _I, _PrevMax, Acc) ->
    Acc.

calculate_max_right(N, L, PrefixSums) ->
    calculate_max_right_recursive(N, L, PrefixSums, N - 1, 0, []).

calculate_max_right_recursive(N, L, PrefixSums, I, PrevMax, Acc) when I >= 0 ->
    WindowSum = 0,
    CurrentMax = 0,
    if
        I > N - L ->
            CurrentMax = PrevMax;
        true ->
            % Sum of subarray A[I ... I+L-1]
            % P[I+L] - P[I]
            WindowSum = lists:nth(I + L + 1, PrefixSums) - lists:nth(I + 1, PrefixSums),
            CurrentMax = max(PrevMax, WindowSum)
    end,
    calculate_max_right_recursive(N, L, PrefixSums, I - 1, CurrentMax, [CurrentMax | Acc]);
calculate_max_right_recursive(_N, _L, _PrefixSums, _I, _PrevMax, Acc) ->
    Acc.

calculate_combined_max_sum(N, L1, L2, MaxLeftL1, MaxRightL2) ->
    % We need to find max(MaxLeftL1[k] + MaxRightL2[k+1])
    % k ranges from L1-1 to N-L2-1
    % MaxLeftL1 is [ML0, ML1, ..., MLN-1]
    % MaxRightL2 is [MR0, MR1, ..., MRN-1]

    % Sublist for MaxLeftL1: elements from index L1-1 to N-L2-1 (0-indexed)
    % Start 1-indexed: (L1-1) + 1 = L1
    % Length: (N-L2-1) - (L1-1) + 1 = N - L1 - L2 + 1
    SubMaxLeftL1 = lists:sublist(MaxLeftL1, L1, N - L1 - L2 + 1),

    % Sublist for MaxRightL2: elements from index L1 to N-L2 (0-indexed)
    % Start 1-indexed: L1 + 1
    % Length: (N-L2) - L1 + 1 = N - L1 - L2 + 1
    SubMaxRightL2 = lists:sublist(MaxRightL2, L1 + 1, N - L1 - L2 + 1),

    Zipped = lists:zip(SubMaxLeftL1, SubMaxRightL2),
    lists:foldl(fun({V1, V2}, MaxAcc) -> max(MaxAcc, V1 + V2) end, 0, Zipped).