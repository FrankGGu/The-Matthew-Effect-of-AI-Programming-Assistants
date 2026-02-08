-module(solution).
-export([max_profit/2]).

max_profit(Inventory, Orders) ->
    % Sort the inventory in descending order.
    % This allows us to process balls from highest value to lowest.
    SortedInventory = lists:sort(fun(A, B) -> A >= B end, Inventory),

    case SortedInventory of
        [] -> 0; % No inventory, no profit
        [H | T] ->
            % Start the recursive process.
            % H is the initial highest value.
            % 1 is the initial count of colors at or above this value.
            % Orders is the total number of balls to sell.
            % 0 is the accumulated profit.
            solve(T, H, 1, Orders, 0)
    end.

solve([], CurrentMaxVal, NumColorsAtOrAboveCurrentMax, RemainingOrders, AccProfit) when RemainingOrders > 0 ->
    % Calculate how many balls each of the 'NumColorsAtOrAboveCurrentMax' colors will sell.
    NumToSellEach = RemainingOrders div NumColorsAtOrAboveCurrentMax,
    % Calculate how many colors will sell one additional ball.
    Remaining = RemainingOrders rem NumColorsAtOrAboveCurrentMax,

    % Calculate profit from 'NumToSellEach' balls sold from each of the colors.
    % The values sold per color are CurrentMaxVal, CurrentMaxVal-1, ..., CurrentMaxVal-NumToSellEach+1.
    % This is an arithmetic series sum: N * (First + Last) / 2
    % N = NumToSellEach
    % First = CurrentMaxVal
    % Last = CurrentMaxVal - NumToSellEach + 1
    SumPerColor = NumToSellEach * (2*CurrentMaxVal - NumToSellEach + 1) div 2,
    ProfitFromEvenDistribution = NumColorsAtOrAboveCurrentMax * SumPerColor,

    % Calculate profit from the 'Remaining' colors selling one additional ball.
    % Each of these balls will have value CurrentMaxVal - NumToSellEach.
    ProfitFromRemaining = Remaining * (CurrentMaxVal - NumToSellEach),

    AccProfit + ProfitFromEvenDistribution + ProfitFromRemaining;

solve(_, _, _, 0, AccProfit) ->
    AccProfit;

solve([H | T], CurrentMaxVal, NumColorsAtOrAboveCurrentMax, RemainingOrders, AccProfit) ->
    % 'H' is the next distinct ball count in the sorted inventory.
    % 'CurrentMaxVal' is the highest value we are currently considering selling from.
    % 'NumColorsAtOrAboveCurrentMax' is the count of colors that currently have 'CurrentMaxVal' or higher.

    % Calculate the difference between the current maximum value and the next distinct value.
    Diff = CurrentMaxVal - H,

    if Diff == 0 ->
        % If H is the same as CurrentMaxVal, it means we found another color with the same max value.
        % We don't sell any balls yet; just increment the count of colors at this max value
        % and continue processing the rest of the inventory.
        solve(T, H, NumColorsAtOrAboveCurrentMax + 1, RemainingOrders, AccProfit);
    true ->
        % If Diff > 0, we can sell balls with values from CurrentMaxVal down to H+1.
        % We have 'NumColorsAtOrAboveCurrentMax' colors that can sell these balls.
        BallsCanSellInThisRange = NumColorsAtOrAboveCurrentMax * Diff,

        if RemainingOrders >= BallsCanSellInThisRange ->
            % If we have enough orders to sell all balls in this range:
            % Calculate the profit from selling 'Diff' balls from each of the
            % 'NumColorsAtOrAboveCurrentMax' colors (values from CurrentMaxVal down to H+1).
            % Arithmetic series sum: N * (First + Last) / 2
            % N = Diff
            % First = CurrentMaxVal
            % Last = H + 1
            SumPerColor = Diff * (CurrentMaxVal + H + 1) div 2,
            ProfitFromThisRange = NumColorsAtOrAboveCurrentMax * SumPerColor,

            NewAccProfit = AccProfit + ProfitFromThisRange,
            NewRemainingOrders = RemainingOrders - BallsCanSellInThisRange,

            % Update CurrentMaxVal to H (as we've sold all balls above H),
            % increment NumColorsAtOrAboveCurrentMax (to include the color that originally had H),
            % and continue with the remaining orders.
            solve(T, H, NumColorsAtOrAboveCurrentMax + 1, NewRemainingOrders, NewAccProfit);
        true ->
            % If RemainingOrders < BallsCanSellInThisRange, this is the final step.
            % We need to sell 'RemainingOrders' balls from the 'NumColorsAtOrAboveCurrentMax' colors.
            NumToSellEach = RemainingOrders div NumColorsAtOrAboveCurrentMax,
            Remaining = RemainingOrders rem NumColorsAtOrAboveCurrentMax,

            % Calculate profit from 'NumToSellEach' balls sold from each of the colors.
            % Values are CurrentMaxVal, CurrentMaxVal-1, ..., CurrentMaxVal-NumToSellEach+1.
            SumPerColor = NumToSellEach * (2*CurrentMaxVal - NumToSellEach + 1) div 2,
            ProfitFromEvenDistribution = NumColorsAtOrAboveCurrentMax * SumPerColor,

            % Calculate profit from the 'Remaining' colors selling one additional ball.
            % Each of these balls will have value CurrentMaxVal - NumToSellEach.
            ProfitFromRemaining = Remaining * (CurrentMaxVal - NumToSellEach),

            % Return the total accumulated profit.
            AccProfit + ProfitFromEvenDistribution + ProfitFromRemaining
        end
    end.