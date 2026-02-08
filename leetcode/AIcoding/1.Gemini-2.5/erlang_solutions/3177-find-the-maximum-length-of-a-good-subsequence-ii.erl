-module(solution).
-export([maxLength/2]).

maxLength(Nums, K) ->
    % Initialize a list of K zeros. Each index `i` (0 to K-1) will store the count
    % of numbers `X` in Nums such that `X rem K == i`.
    % Erlang lists are 1-indexed for `lists:nth` and `lists:replace_nth`,
    % so remainder `i` corresponds to index `i + 1`.
    InitialCounts = lists:duplicate(K, 0),

    % Fold over the input list Nums to populate the counts.
    FinalCounts = lists:foldl(
        fun(Num, AccCounts) ->
            Remainder = Num rem K,
            % Get the current count for this remainder.
            CurrentCount = lists:nth(Remainder + 1, AccCounts),
            % Increment the count and create a new list with the updated value.
            lists:replace_nth(Remainder + 1, CurrentCount + 1, AccCounts)
        end,
        InitialCounts,
        Nums
    ),

    % Find the maximum count among all remainders.
    % If Nums is empty, FinalCounts will be all zeros, and lists:max will return 0.
    % This correctly handles the case where no good subsequence can be formed.
    lists:max(FinalCounts).