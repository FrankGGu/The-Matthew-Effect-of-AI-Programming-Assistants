-module(solution).
-export([putMarbles/2]).

putMarbles(Weights, K) ->
    N = length(Weights),

    % If K=1, there are no cuts, and the score is weights[0] + weights[N-1].
    % Max score = Min score, so the difference is 0.
    % The problem constraints state 2 <= K <= N, so K-1 is always at least 1.
    % If K=N, then N-1 cuts are made, meaning each marble is in its own bag.
    % In this case, all N-1 possible pair sums (weights[i] + weights[i+1]) are chosen.
    % The sum of the largest K-1 pairs will be equal to the sum of the smallest K-1 pairs,
    % resulting in a difference of 0, which is correct for K=N.

    % Generate all N-1 possible sums of adjacent weights.
    % For a list [W0, W1, ..., W(N-1)], the pairs are (W0, W1), (W1, W2), ..., (W(N-2), W(N-1)).
    % In Erlang (1-indexed lists), this means sums of (lists:nth(I, Weights) + lists:nth(I+1, Weights))
    % for I from 1 to N-1.
    Pairs = [lists:nth(I, Weights) + lists:nth(I+1, Weights) || I <- lists:seq(1, N-1)],

    % Sort the list of pair sums.
    SortedPairs = lists:sort(Pairs),

    % Calculate the sum of the smallest K-1 pairs.
    % These are the first K-1 elements in the sorted list.
    SmallestKMinus1Sum = lists:sum(lists:sublist(SortedPairs, 1, K-1)),

    % Calculate the sum of the largest K-1 pairs.
    % These are the last K-1 elements in the sorted list.
    % The total number of pairs is N-1.
    % The starting index for the last K-1 elements is (N-1) - (K-1) + 1 = N - K + 1.
    LargestKMinus1Sum = lists:sum(lists:sublist(SortedPairs, N - K + 1, K-1)),

    % The difference between the maximum and minimum total scores is the
    % difference between the sum of the largest K-1 chosen pairs and the
    % sum of the smallest K-1 chosen pairs.
    LargestKMinus1Sum - SmallestKMinus1Sum.