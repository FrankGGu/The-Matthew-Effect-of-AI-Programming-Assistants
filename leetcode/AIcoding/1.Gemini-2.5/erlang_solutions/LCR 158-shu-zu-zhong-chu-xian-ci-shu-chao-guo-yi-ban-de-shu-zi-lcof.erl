-module(solution).
-export([max_profit/2]).

max_profit(Inventory, Orders) ->
    Mod = 1000000007,
    % Sort in descending order
    SortedInventory = lists:sort(fun(A, B) -> A >= B end, Inventory),
    max_profit_loop(SortedInventory, Orders, 0, Mod).

max_profit_loop([], _, Total, _) -> Total; % No more balls in inventory
max_profit_loop(_, 0, Total, _) -> Total; % No more orders

max_profit_loop([CurrentVal | Rest], Orders, Total, Mod) ->
    % If CurrentVal is 0, we can't sell any more profitable balls.
    % All remaining balls are 0 or less, so stop.
    if CurrentVal == 0 ->
        Total;
    true ->
        % Find how many colors have CurrentVal balls, and what the next distinct smaller value is.
        % Count: number of items equal to CurrentVal
        % NextList: the list starting from the first item *smaller* than CurrentVal
        {Count, NextList} = count_and_split(Rest, CurrentVal, 1),

        NextVal = case NextList of
                      [H | _] -> H;
                      [] -> 0 % No more elements, so the next value is 0
                  end,

        LevelsToSell = CurrentVal - NextVal,

        % LevelsToSell will always be > 0 here because CurrentVal > 0 and NextVal < CurrentVal (or NextVal = 0).
        % If NextVal == CurrentVal, count_and_split would have included it in Count.

        BallsInBlock = Count * LevelsToSell,

        if
            Orders >= BallsInBlock ->
                % We can sell all balls in this block
                % Sum of an arithmetic series: CurrentVal + (CurrentVal-1) + ... + (NextVal+1)
                % NumTerms = LevelsToSell
                % FirstTerm = CurrentVal
                % LastTerm = NextVal + 1
                SumOfLevels = (LevelsToSell * (CurrentVal + NextVal + 1)) div 2,
                ValueFromBlock = (Count * SumOfLevels) rem Mod,
                NewTotal = (Total + ValueFromBlock) rem Mod,
                max_profit_loop(NextList, Orders - BallsInBlock, NewTotal, Mod);
            true ->
                % Orders are less than BallsInBlock, so we only sell Orders balls
                % We sell 'Orders' balls from 'Count' colors.
                NumFullLevels = Orders div Count,
                RemainingOrders = Orders rem Count,

                % Value from full levels: CurrentVal down to CurrentVal - NumFullLevels + 1
                % NumTerms = NumFullLevels
                % FirstTerm = CurrentVal
                % LastTerm = CurrentVal - NumFullLevels + 1
                SumFullLevels = (NumFullLevels * (CurrentVal + (CurrentVal - NumFullLevels + 1))) div 2,
                ValueFromFullLevels = (Count * SumFullLevels) rem Mod,

                % Value from remaining orders: RemainingOrders balls at price CurrentVal - NumFullLevels
                ValueFromRemaining = (RemainingOrders * (CurrentVal - NumFullLevels)) rem Mod,

                FinalTotal = (Total + ValueFromFullLevels + ValueFromRemaining) rem Mod,
                FinalTotal
        end
    end.

count_and_split([H | T], CurrentVal, Count) when H == CurrentVal ->
    count_and_split(T, CurrentVal, Count + 1);
count_and_split(List, _, Count) ->
    {Count, List}.