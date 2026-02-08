-module(solution).
-export([findSubsequences/1]).

findSubsequences(Nums) ->
    % Start the backtracking process.
    % Nums: The original list of numbers.
    % []: The current non-decreasing subsequence being built, initially empty and reversed.
    % gb_sets:new(): The accumulator set for unique results.
    FinalSet = backtrack(Nums, [], gb_sets:new()),
    % Convert the final set of unique subsequences to a list of lists.
    gb_sets:to_list(FinalSet).

backtrack(Nums, CurrentListReversed, AccSetIn) ->
    % If the current subsequence has at least two elements, add its reversed version to the result set.
    % We reverse it here because CurrentListReversed is built by prepending elements.
    UpdatedAccSet = case length(CurrentListReversed) >= 2 of
        true -> gb_sets:add(lists:reverse(CurrentListReversed), AccSetIn);
        false -> AccSetIn
    end,

    % Start the loop to consider elements from the 'Nums' list.
    % This loop explores branches where elements are either included or skipped.
    % It manages the 'AccSet' and a 'UsedAtCurrentLevel' set to handle duplicates in the input array.
    loop_nums(Nums, CurrentListReversed, UpdatedAccSet, gb_sets:new()).

loop_nums([Num | RestOfNums], CurrentListReversed, AccSet, UsedAtCurrentLevel) ->
    % Check if this number has already been used at this level of recursion.
    % This is crucial for handling duplicate numbers in the input array (e.g., [4,7,7])
    % to ensure that if '7' has already been considered as a choice at this level,
    % we don't process it again from a different index if it's the same value.
    case gb_sets:is_member(Num, UsedAtCurrentLevel) of
        true ->
            % If used, skip this number and continue to the next element in 'Nums'.
            loop_nums(RestOfNums, CurrentListReversed, AccSet, UsedAtCurrentLevel);
        false ->
            % Determine the last element of the current subsequence.
            % If CurrentListReversed is empty, use a value (-101) smaller than any possible input number
            % to ensure the first number can always be added.
            LastInCurrent = case CurrentListReversed of
                                [] -> -101; % Min input is -100
                                [H|_] -> H
                            end,

            % If the current number is non-decreasing compared to the last element of the subsequence.
            case Num >= LastInCurrent of
                true ->
                    % Add the current number to the set of used numbers for this level.
                    NewUsedAtCurrentLevel = gb_sets:add(Num, UsedAtCurrentLevel),
                    % Recursively call 'backtrack' to explore the path where 'Num' is included.
                    % The 'Nums' list for the recursive call starts from 'RestOfNums'
                    % because we can only pick elements from the right of the current 'Num'.
                    NewAccSet = backtrack(RestOfNums, [Num | CurrentListReversed], AccSet),
                    % Continue to the next element in 'Nums' for the current level,
                    % passing the updated 'AccSet' and 'UsedAtCurrentLevel'.
                    loop_nums(RestOfNums, CurrentListReversed, NewAccSet, NewUsedAtCurrentLevel);
                false ->
                    % If not non-decreasing, skip this number and continue to the next element in 'Nums'.
                    % We do not add 'Num' to 'UsedAtCurrentLevel' here because it wasn't a valid choice.
                    loop_nums(RestOfNums, CurrentListReversed, AccSet, UsedAtCurrentLevel)
            end
    end;
loop_nums([], _CurrentListReversed, AccSet, _UsedAtCurrentLevel) ->
    AccSet.