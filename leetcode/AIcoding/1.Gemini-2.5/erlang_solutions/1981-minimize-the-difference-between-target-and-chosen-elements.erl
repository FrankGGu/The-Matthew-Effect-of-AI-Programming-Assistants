-module(solution).
-export([minimizeTheDifference/2]).

minimizeTheDifference(Mat, Target) ->
    % Initialize the set of possible sums with elements from the first row.
    % gb_sets are used for efficient storage and lookup of distinct sums.
    InitialSums = gb_sets:from_list(hd(Mat)),

    % Iterate through the rest of the rows, accumulating all possible sums.
    AllPossibleSums = lists:foldl(
        fun(Row, AccSums) ->
            % For each row, we generate a new set of sums.
            % NewSums will store sums formed by adding an element from the current
            % Row to each sum accumulated so far (AccSums).
            lists:foldl(
                fun(AccSum, CurrentNewSums) ->
                    % For each element in the current Row, add it to AccSum.
                    % Add the resulting sum to the CurrentNewSums set.
                    lists:foldl(
                        fun(Elem, InnerCurrentNewSums) ->
                            gb_sets:add(AccSum + Elem, InnerCurrentNewSums)
                        end,
                        CurrentNewSums,
                        Row
                    )
                end,
                gb_sets:new(), % Start with an empty set for the new sums of this row
                gb_sets:to_list(AccSums) % Convert previous sums to a list to iterate
            )
        end,
        InitialSums,
        tl(Mat) % Process all rows except the first one
    ),

    % Convert the final set of all possible sums to a list.
    % This list will be sorted because gb_sets maintains elements in order.
    SumsList = gb_sets:to_list(AllPossibleSums),

    % Find the minimum absolute difference between any sum in SumsList and the Target.
    lists:foldl(
        fun(Sum, CurrentMinDiff) ->
            Diff = abs(Sum - Target),
            min(Diff, CurrentMinDiff)
        end,
        abs(hd(SumsList) - Target), % Initialize with the difference of the first sum
        tl(SumsList) % Iterate from the second sum onwards
    ).