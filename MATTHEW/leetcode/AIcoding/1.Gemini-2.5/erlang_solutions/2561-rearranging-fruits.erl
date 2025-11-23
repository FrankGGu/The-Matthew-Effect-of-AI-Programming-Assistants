-module(solution).
-export([minCost/2]).

minCost(Basket1, Basket2) ->
    try
        % Create frequency maps for each basket
        Map1 = lists:foldl(fun(F, Acc) -> maps:update_with(F, fun(V) -> V + 1 end, 1, Acc) end, #{}, Basket1),
        Map2 = lists:foldl(fun(F, Acc) -> maps:update_with(F, fun(V) -> V + 1 end, 1, Acc) end, #{}, Basket2),

        % Merge maps to get combined frequencies
        CombinedMap = maps:merge_with(fun(_, V1, V2) -> V1 + V2 end, Map1, Map2),

        % Find the smallest fruit value overall
        MinFruitOverall = lists:min(maps:keys(CombinedMap)),

        % Initialize lists for excess fruits
        ExcessB1 = [],
        ExcessB2 = [],

        % Iterate through combined frequencies to check feasibility and identify excess fruits
        {FinalExcessB1, FinalExcessB2} = maps:fold(
            fun(F, TotalCount, {AccExcessB1, AccExcessB2}) ->
                case TotalCount rem 2 of
                    1 -> throw(-1); % If any fruit has an odd total count, it's impossible
                    0 ->
                        TargetCount = TotalCount div 2,
                        CountInB1 = maps:get(F, Map1, 0),
                        CountInB2 = maps:get(F, Map2, 0),

                        % Add fruits that are in excess in Basket1
                        NewAccExcessB1 = lists:duplicate(CountInB1 - TargetCount, F) ++ AccExcessB1,
                        % Add fruits that are in excess in Basket2
                        NewAccExcessB2 = lists:duplicate(CountInB2 - TargetCount, F) ++ AccExcessB2,
                        {NewAccExcessB1, NewAccExcessB2}
                end
            end,
            {ExcessB1, ExcessB2},
            CombinedMap
        ),

        % Sort the lists of excess fruits
        SortedExcessB1 = lists:sort(FinalExcessB1),
        SortedExcessB2 = lists:sort(FinalExcessB2),

        % The number of fruits that need to be moved from B1 to B2 (and vice-versa)
        % These lengths must be equal.
        K = length(SortedExcessB1), 

        % Combine all excess fruits and sort them
        AllExcess = SortedExcessB1 ++ SortedExcessB2,
        SortedAllExcess = lists:sort(AllExcess),

        % The cost is determined by the K smallest fruits among all excess fruits.
        % For each such fruit F, the cost to move it is min(F, 2 * MinFruitOverall).
        % This is because we can either swap F directly with another excess fruit (effectively paying F if it's the smaller one in a pair)
        % or use the smallest overall fruit (MinFruitOverall) as an intermediary twice (cost 2 * MinFruitOverall).
        SmallestKExcess = lists:sublist(SortedAllExcess, K),

        lists:foldl(fun(F, AccCost) -> AccCost + min(F, 2 * MinFruitOverall) end, 0, SmallestKExcess)
    catch
        -1 -> -1 % Catch the impossibility signal
    end.