-module(solution).
-export([max_profit/2]).

max_profit(Stock, K) ->
    Mod = 1000000007,

    % 1. Count frequencies of each stock value.
    CountsMap = lists:foldl(
        fun(Val, Acc) ->
            maps:update_with(Val, fun(C) -> C + 1 end, 1, Acc)
        end,
        #{},
        Stock
    ),

    % 2. Convert to a list of {Value, Count} tuples and sort by Value in descending order.
    SortedCounts = lists:sort(
        fun({V1, _}, {V2, _}) -> V1 > V2 end,
        maps:to_list(CountsMap)
    ),

    % 3. Iterate through the sorted list to calculate maximum profit.
    calculate_profit(SortedCounts, K, 0, 0, Mod).

calculate_profit([], _RemainingK, TotalProfit, _ItemsAtCurrentLevel, _Mod) ->
    TotalProfit;
calculate_profit([{CurrentValue, CurrentCount} | Rest], RemainingK, TotalProfit, PrevItemsAtCurrentLevel, Mod) ->
    % ItemsAtCurrentLevel is the total count of items that are currently at CurrentValue
    % (either they started at CurrentValue or were reduced to it from a higher value).
    ItemsAtCurrentLevel = PrevItemsAtCurrentLevel + CurrentCount,

    % Determine the next distinct value. If no more distinct values, consider 0.
    NextValue = case Rest of
                    [] -> 0;
                    [{NVal, _} | _] -> NVal
                end,

    % Diff is the number of times we can sell each of the ItemsAtCurrentLevel items
    % before their value drops below NextValue.
    Diff = CurrentValue - NextValue,

    % CanSell is the total number of sales we can make from ItemsAtCurrentLevel items
    % before any of them drop below NextValue.
    CanSell = ItemsAtCurrentLevel * Diff,

    if RemainingK =< CanSell ->
        % We have enough K to sell until CurrentValue drops to NextValue (or 0)
        % or we run out of K before reaching NextValue.
        % This is the final step where K is fully utilized.

        % NumFullLevels: how many times each of the ItemsAtCurrentLevel items can be sold.
        NumFullLevels = RemainingK div ItemsAtCurrentLevel,
        % RemainingSalesInLastLevel: how many items are sold one extra time.
        RemainingSalesInLastLevel = RemainingK rem ItemsAtCurrentLevel,

        % Calculate profit from NumFullLevels full rounds of sales for all ItemsAtCurrentLevel items.
        % Sum of an arithmetic series: (FirstTerm + LastTerm) * NumTerms / 2
        FirstTermFull = CurrentValue,
        LastTermFull = CurrentValue - NumFullLevels + 1,
        SumFullLevels = ((FirstTermFull + LastTermFull) * NumFullLevels) div 2,
        ProfitFromFullLevels = (ItemsAtCurrentLevel * SumFullLevels) rem Mod,

        % Calculate profit from RemainingSalesInLastLevel items sold one additional time.
        ValueForLastLevel = CurrentValue - NumFullLevels,
        ProfitFromRemaining = (RemainingSalesInLastLevel * ValueForLastLevel) rem Mod,

        NewTotalProfit = (TotalProfit + ProfitFromFullLevels + ProfitFromRemaining) rem Mod,
        NewTotalProfit; % This is the final answer

    else ->
        % We sell all items from CurrentValue down to NextValue.
        % Calculate profit from selling ItemsAtCurrentLevel items, reducing their value from CurrentValue to NextValue + 1.

        FirstTermStep = CurrentValue,
        LastTermStep = NextValue + 1,
        SumThisStep = ((FirstTermStep + LastTermStep) * Diff) div 2,
        ProfitForThisStep = (ItemsAtCurrentLevel * SumThisStep) rem Mod,

        NewTotalProfit = (TotalProfit + ProfitForThisStep) rem Mod,
        NewRemainingK = RemainingK - CanSell,

        % Continue to the next distinct value level.
        calculate_profit(Rest, NewRemainingK, NewTotalProfit, ItemsAtCurrentLevel, Mod)
    end.