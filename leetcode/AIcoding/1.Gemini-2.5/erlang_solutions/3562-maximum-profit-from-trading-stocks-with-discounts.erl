-module(solution).
-export([max_profit/2]).

max_profit(Prices, Fee) ->
    case Prices of
        [] -> 0;
        [H | T] ->
            % Initialize 'hold' with the profit after buying the first stock.
            % Initialize 'cash' with 0 profit (no stock held).
            fold_prices(T, -H, 0, Fee)
    end.

fold_prices([], _Hold, Cash, _Fee) ->
    Cash;
fold_prices([Price | T], Hold, Cash, Fee) ->
    % Calculate the maximum profit if we hold a stock after considering the current price.
    % This can be either keeping the previously held stock, or buying a new one today.
    NewHold = max(Hold, Cash - Price),

    % Calculate the maximum profit if we don't hold a stock after considering the current price.
    % This can be either keeping the previously unheld state, or selling the stock held today.
    NewCash = max(Cash, Hold + Price - Fee),

    fold_prices(T, NewHold, NewCash, Fee).

max(A, B) ->
    if
        A >= B -> A;
        true -> B
    end.