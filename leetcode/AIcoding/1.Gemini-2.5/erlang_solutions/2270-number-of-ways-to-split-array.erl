-module(solution).
-export([waysToSplit/1]).

waysToSplit(Nums) ->
    N = length(Nums),
    % Calculate prefix sums. PrefixSumsList will be [0, Nums[0], Nums[0]+Nums[1], ..., TotalSum].
    % Its length will be N+1.
    % PrefixSumsList[k] corresponds to sum(Nums[0...k-1]) if 0-indexed.
    % array:get(K, PrefixArray) will give sum(Nums[0...K-1]).
    PrefixSumsList = lists:foldl(fun(X, Acc) -> Acc ++ [lists:last(Acc) + X] end, [0], Nums),

    % Convert to an array for O(1) random access.
    PrefixArray = array:from_list(PrefixSumsList),

    % I is the 0-indexed split point for the first subarray (Nums[0...I]).
    % J is the 0-indexed split point for the second subarray (Nums[I+1...J]).
    % The third subarray is Nums[J+1...N-1].

    % Constraints on I and J:
    % First subarray must be non-empty: I >= 0.
    % Second subarray must be non-empty: I+1 <= J.
    % Third subarray must be non-empty: J+1 <= N-1 => J <= N-2.
    % Combining: 0 <= I < J <= N-2.
    % Minimum N=3. For N=3, I=0, J=1.
    % Max I: N-3. (e.g., if N=3, Max I=0. If N=4, Max I=1)
    % Max J: N-2. (e.g., if N=3, Max J=1. If N=4, Max J=2)

    Max_I = N - 3,

    % Start the recursive counting process.
    % count_splits(CurrentI, MaxI, N, PrefixArray, AccumulatorCount)
    count_splits(0, Max_I, N, PrefixArray, 0).

count_splits(I, Max_I, N, PrefixArray, AccCount) when I =< Max_I ->
    % S1 = sum(Nums[0...I])
    % This corresponds to PrefixArray element at index I+1.
    S1 = array:get(I + 1, PrefixArray),

    % Inner loop for J (second split point)
    Min_J = I + 1, % J must be greater than I
    Max_J = N - 2, % J must leave at least one element for the third part

    NewAccCount = count_splits_j(I, Min_J, Max_J, N, S1, PrefixArray, AccCount),

    % Recurse for the next I
    count_splits(I + 1, Max_I, N, PrefixArray, NewAccCount);
count_splits(_I, _Max_I, _N, _PrefixArray, AccCount) ->
    % Base case: I has exceeded Max_I, return final count
    AccCount.

count_splits_j(I, J, Max_J, N, S1, PrefixArray, AccCount) when J =< Max_J ->
    % S2 = sum(Nums[I+1...J])
    % This corresponds to PrefixArray element at index J+1 minus PrefixArray element at index I+1.
    S2 = array:get(J + 1, PrefixArray) - array:get(I + 1, PrefixArray),

    % S3 = sum(Nums[J+1...N-1])
    % This corresponds to PrefixArray element at index N (total sum) minus PrefixArray element at index J+1.
    S3 = array:get(N, PrefixArray) - array:get(J + 1, PrefixArray),

    NewAccCount = if 
                      S1 =< S2 andalso S2 =< S3 -> AccCount + 1;
                      true -> AccCount
                  end,

    % Recurse for the next J
    count_splits_j(I, J + 1, Max_J, N, S1, PrefixArray, NewAccCount);
count_splits_j(_I, _J, _Max_J, _N, _S1, _PrefixArray, AccCount) ->
    % Base case: J has exceeded Max_J, return current count for this I
    AccCount.