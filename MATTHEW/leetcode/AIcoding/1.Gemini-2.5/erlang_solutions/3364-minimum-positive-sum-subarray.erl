-module(solution).
-export([min_positive_sum_subarray/1]).

min_positive_sum_subarray(Nums) ->
    % Use a very large number for the initial minimum positive sum.
    % Erlang integers handle arbitrary precision, so this is effectively "infinity".
    InitialMinPositiveSum = 100000000000000000000000000000000000000000000000000000,

    % Initialize current_prefix_sum to 0.
    CurrentPrefixSum = 0,

    % Initialize a gb_tree (balanced binary search tree) with 0 as the first prefix sum.
    % The key and value are the same for simplicity, storing the prefix sum itself.
    SeenPrefixSumsTree = gb_trees:insert(0, 0, gb_trees:new()),

    % Call a helper function to iterate through the numbers.
    find_min(Nums, CurrentPrefixSum, SeenPrefixSumsTree, InitialMinPositiveSum).

find_min([], _AccPrefixSum, _Tree, MinPositiveSum) ->
    MinPositiveSum;
find_min([H|T], AccPrefixSum, Tree, MinPositiveSum) ->
    NewAccPrefixSum = AccPrefixSum + H,

    % Find the largest prefix sum (PrevKey) in the tree such that PrevKey < NewAccPrefixSum.
    % gb_trees:prev(Key, Tree) returns {ok, PrevKey, PrevValue} if such a key exists,
    % or 'error' if no key in the tree is strictly less than Key.
    case gb_trees:prev(NewAccPrefixSum, Tree) of
        {ok, PrevKey, _PrevValue} ->
            Diff = NewAccPrefixSum - PrevKey,
            % We are interested in the minimum *positive* difference.
            % Since PrevKey < NewAccPrefixSum, Diff will always be positive.
            NewMinPositiveSum = min(MinPositiveSum, Diff);
        error ->
            % No prefix sum in the tree is less than NewAccPrefixSum.
            % This means no positive sum subarray ending here can be formed with previous prefix sums.
            NewMinPositiveSum = MinPositiveSum
    end,

    % Add the current prefix sum to the tree for future calculations.
    % If NewAccPrefixSum already exists, gb_trees:insert updates its value (which is fine here).
    NewTree = gb_trees:insert(NewAccPrefixSum, NewAccPrefixSum, Tree),

    % Continue processing the rest of the list.
    find_min(T, NewAccPrefixSum, NewTree, NewMinPositiveSum).