-module(solution).
-export([maximum_multiplication_score/2]).

maximum_multiplication_score(Nums, Multipliers) ->
    N = length(Nums),
    M = length(Multipliers),

    % Convert lists to tuples for O(1) element access
    NumsTuple = list_to_tuple(Nums),
    MultipliersTuple = list_to_tuple(Multipliers),

    % Initialize memoization table (gb_trees)
    Memo = gb_trees:empty(),

    % Call the recursive solver. It returns {Score, UpdatedMemo}.
    % We only need the final score.
    {Score, _FinalMemo} = solve(0, 0, NumsTuple, MultipliersTuple, N, M, Memo),
    Score.

solve(I, J, _NumsTuple, _MultipliersTuple, _N, M, Memo) when I == M ->
    % Base case: All multipliers have been used, score is 0.
    {0, Memo};
solve(I, J, NumsTuple, MultipliersTuple, N, M, Memo) ->
    Key = {I, J},
    case gb_trees:lookup(Key, Memo) of
        {value, Score} ->
            % If already computed, return cached value
            {Score, Memo};
        none ->
            % Calculate values for the current operation
            % Tuple elements are 1-indexed, so we add 1 to 0-indexed indices.

            % Element to take from the left side of Nums
            LeftVal = element(J + 1, NumsTuple),

            % Element to take from the right side of Nums
            % Number of elements taken from the right is (I - J)
            % So the 0-indexed index of the rightmost available element is N - 1 - (I - J)
            RightIdx = N - 1 - (I - J),
            RightVal = element(RightIdx + 1, NumsTuple),

            % Current multiplier
            Multiplier = element(I + 1, MultipliersTuple),

            % Recursively calculate scores for both choices:
            % 1. Take from left: increment multiplier index and left count
            {ScoreFromLeft, Memo1} = solve(I + 1, J + 1, NumsTuple, MultipliersTuple, N, M, Memo),

            % 2. Take from right: increment multiplier index, left count remains same
            % Pass Memo1 to ensure memoization from the first branch is available
            {ScoreFromRight, Memo2} = solve(I + 1, J, NumsTuple, MultipliersTuple, N, M, Memo1),

            % Combine current multiplication with recursive scores and choose the maximum
            Result = max(Multiplier * LeftVal + ScoreFromLeft,
                         Multiplier * RightVal + ScoreFromRight),

            % Store the result in the memo and return it
            UpdatedMemo = gb_trees:insert(Key, Result, Memo2),
            {Result, UpdatedMemo}
    end.