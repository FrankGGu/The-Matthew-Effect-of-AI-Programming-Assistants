-module(solution).
-export([last_stone_weight_ii/1]).

last_stone_weight_ii(Stones) ->
    TotalSum = lists:sum(Stones),
    Target = TotalSum div 2,

    % Initialize a set with 0, representing that a sum of 0 is always achievable
    PossibleSums = gb_sets:from_list([0]),

    % Iterate through each stone
    FinalPossibleSums = lists:foldl(
        fun(Stone, AccPossibleSums) ->
            % For each stone, iterate through the sums achievable BEFORE adding this stone.
            % We use gb_sets:to_list to get a snapshot of AccPossibleSums
            % to avoid modifying the set while iterating over it in the inner fold.
            lists:foldl(
                fun(ExistingSum, CurrentPossibleSums) ->
                    NewSum = ExistingSum + Stone,
                    % If the new sum is within our target range, add it to the set
                    if NewSum =< Target ->
                        gb_sets:add(NewSum, CurrentPossibleSums);
                    true ->
                        CurrentPossibleSums
                    end
                end,
                AccPossibleSums, % Start the inner fold with the current accumulated set
                gb_sets:to_list(AccPossibleSums) % Iterate over existing sums
            )
        end,
        PossibleSums, % Initial set for the outer fold
        Stones
    ),

    % Find the maximum sum that can be achieved within the Target range
    MaxSumAchieved = gb_sets:max(FinalPossibleSums),

    % The result is TotalSum - 2 * MaxSumAchieved.
    % This is because if one pile sums to MaxSumAchieved, the other pile sums to
    % TotalSum - MaxSumAchieved. The difference is
    % (TotalSum - MaxSumAchieved) - MaxSumAchieved = TotalSum - 2 * MaxSumAchieved.
    TotalSum - 2 * MaxSumAchieved.