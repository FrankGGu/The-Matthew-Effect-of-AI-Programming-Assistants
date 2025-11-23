-module(solution).
-export([minCost/2]).

minCost(Nums, Costs) ->
    % 1. Combine Nums and Costs into a list of {Num, Cost} tuples.
    Pairs = lists:zip(Nums, Costs),

    % 2. Sort the pairs based on Num.
    %    lists:sort/1 sorts a list of tuples by the first element, then the second.
    SortedPairs = lists:sort(Pairs),

    % 3. Calculate the total weight (sum of all costs).
    TotalWeight = lists:foldl(fun({_, C}, Acc) -> Acc + C end, 0, SortedPairs),

    % 4. Find the weighted median X.
    %    The target weight for the median is TotalWeight / 2.
    %    We find the first Num such that the cumulative cost up to it
    %    is greater than or equal to this target.
    MedianX = find_weighted_median(SortedPairs, TotalWeight div 2, 0),

    % 5. Calculate the total cost using the median X.
    lists:foldl(fun({Num, C}, Acc) -> Acc + abs(Num - MedianX) * C end, 0, SortedPairs).

find_weighted_median([{Num, C} | Rest], TargetWeight, CurrentWeightSum) ->
    NewCurrentWeightSum = CurrentWeightSum + C,
    if
        NewCurrentWeightSum >= TargetWeight ->
            Num;
        true ->
            find_weighted_median(Rest, TargetWeight, NewCurrentWeightSum)
    end.