-module(solution).
-export([maximumOr/1]).

maximumOr(Nums) ->
    N = length(Nums),

    % Sort the numbers in descending order.
    % lists:sort/2 with a custom comparison function for descending order.
    SortedNums = lists:sort(fun(A, B) -> A >= B end, Nums),

    % Limit the number of elements to consider for combinations.
    % For problems involving bitwise OR and a small fixed number of elements (k=3 here),
    % it's often sufficient to consider a small constant number of the largest elements.
    % Since numbers are up to 10^9 (approx 30 bits), considering 2-3 times the number of bits
    % (e.g., 60-100 elements) is a common heuristic.
    Limit = min(N, 100), % Use 100 as a safe upper bound for candidates

    % Take the first 'Limit' elements from the sorted list.
    Candidates = lists:sublist(SortedNums, Limit),

    % Find the maximum OR value by iterating through combinations of three distinct elements
    % from the Candidates list.
    find_max_or_combinations(Candidates, 0).

find_max_or_combinations(Candidates, CurrentMaxOr) ->
    Len = length(Candidates),

    % Use nested folds to iterate through all unique combinations of three distinct indices (I, J, K)
    % such that I < J < K. This ensures we pick three distinct elements.
    lists:foldl(fun(I, AccMaxOr1) ->
        lists:foldl(fun(J, AccMaxOr2) ->
            lists:foldl(fun(K, AccMaxOr3) ->
                % lists:nth is 1-indexed, so add 1 to the 0-indexed loop variables.
                ValI = lists:nth(I + 1, Candidates),
                ValJ = lists:nth(J + 1, Candidates),
                ValK = lists:nth(K + 1, Candidates),

                CurrentOr = ValI bor ValJ bor ValK,
                max(AccMaxOr3, CurrentOr)
            end, AccMaxOr2, lists:seq(J + 1, Len - 1)) % K iterates from J+1 to Len-1
        end, AccMaxOr1, lists:seq(I + 1, Len - 1)) % J iterates from I+1 to Len-1
    end, CurrentMaxOr, lists:seq(0, Len - 1)). % I iterates from 0 to Len-1