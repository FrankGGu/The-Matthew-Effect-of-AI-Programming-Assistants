-module(solution).
-export([shortest_subarray_with_sum_at_least_k/2]).

shortest_subarray_with_sum_at_least_k(A, K) ->
    N = length(A),

    % Calculate prefix sums and store in an array for O(1) access
    % PrefixSums[j] = A[0] + ... + A[j-1]
    % PrefixSums[0] = 0
    PrefixSumsList = lists:scan(fun(X, Sum) -> Sum + X end, 0, A), % [P0, P1, ..., PN]
    PrefixSumsArray = array:from_list(PrefixSumsList),

    MinLen = N + 1, % Initialize with a value larger than any possible length

    % Deque will store indices `j` such that P[j] is increasing.
    % Using gb_trees to simulate a deque with O(log N) operations.
    % Key: index, Value: prefix sum P[index]
    Deque = gb_trees:empty(),

    % Add index 0 initially (for P[0])
    InitialDeque = gb_trees:insert(0, array:get(0, PrefixSumsArray), Deque),

    % Iterate j from 0 to N (inclusive)
    % Helper function: `solve(J, MinLen, Deque, PrefixSumsArray, K, MaxJ)`
    Result = solve(0, MinLen, InitialDeque, PrefixSumsArray, K, N),

    case Result of
        N + 1 -> -1; % No such subarray found
        _ -> Result
    end.

solve(J, MinLen, Deque, PrefixSumsArray, K, MaxJ) when J =< MaxJ ->
    CurrentPj = array:get(J, PrefixSumsArray), % P[J]

    % Step 1: Remove from front while P[J] - P[peek_front(Deque)] >= K
    % peek_front is smallest index in gb_trees
    {NewMinLen1, Deque1} = process_front(J, CurrentPj, MinLen, Deque, PrefixSumsArray, K),

    % Step 2: Remove from back while P[peek_back(Deque1)] >= P[J]
    % peek_back is largest index in gb_trees
    Deque2 = process_back(CurrentPj, Deque1, PrefixSumsArray),

    % Step 3: Add J to back of deque (insert J into gb_trees)
    Deque3 = gb_trees:insert(J, CurrentPj, Deque2),

    solve(J + 1, NewMinLen1, Deque3, PrefixSumsArray, K, MaxJ);
solve(_, MinLen, _, _, _, _) ->
    MinLen.

process_front(J, CurrentPj, MinLen, Deque, PrefixSumsArray, K) ->
    case gb_trees:is_empty(Deque) of
        true -> {MinLen, Deque};
        false ->
            IdxI = gb_trees:smallest(Deque), % Get smallest index (front of deque)
            Pi = array:get(IdxI, PrefixSumsArray), % Get P[IdxI]
            if (CurrentPj - Pi) >= K ->
                {_, _, DequeAfterPop} = gb_trees:take_smallest(Deque), % Remove from front
                NewMinLen = min(MinLen, J - IdxI),
                process_front(J, CurrentPj, NewMinLen, DequeAfterPop, PrefixSumsArray, K);
            true ->
                {MinLen, Deque}
            end
    end.

process_back(CurrentPj, Deque, PrefixSumsArray) ->
    case gb_trees:is_empty(Deque) of
        true -> Deque;
        false ->
            IdxK = gb_trees:largest(Deque), % Get largest index (back of deque)
            Pk = array:get(IdxK, PrefixSumsArray), % Get P[IdxK]
            if Pk >= CurrentPj ->
                {_, _, DequeAfterPop} = gb_trees:take_largest(Deque), % Remove from back
                process_back(CurrentPj, DequeAfterPop, PrefixSumsArray);
            true ->
                Deque
            end
    end.