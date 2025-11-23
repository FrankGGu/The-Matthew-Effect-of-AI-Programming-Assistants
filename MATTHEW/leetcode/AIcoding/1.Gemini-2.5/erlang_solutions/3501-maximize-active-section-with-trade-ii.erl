-module(solution).
-export([max_profit/1]).

max_profit(Prices) ->
    % The state is represented by a tuple: {T1Buy, T1Sell, T2Buy, T2Sell}
    % T1Buy: Maximum profit after the first buy transaction.
    %        This is effectively the negative of the minimum cost to buy for the first transaction.
    % T1Sell: Maximum profit after the first sell transaction.
    % T2Buy: Maximum profit after the second buy transaction.
    %        This implies a first sell must have occurred before this buy.
    % T2Sell: Maximum profit after the second sell transaction.
    %        This implies a second buy must have occurred before this sell.

    % Initialize T1Buy and T2Buy to a very small negative number (representing -infinity)
    % because initially, no stock has been bought, so profit after buying is negative.
    % Initialize T1Sell and T2Sell to 0, as no profit has been made yet.
    {_FinalT1Buy, _FinalT1Sell, _FinalT2Buy, FinalT2Sell} = lists:foldl(
        fun(Price, {T1BuyAcc, T1SellAcc, T2BuyAcc, T2SellAcc}) ->
            % Update T2Sell: Max profit after selling for the second time.
            %                 Either keep the previous max T2Sell, or sell at the current Price
            %                 after having made a T2Buy transaction.
            NewT2Sell = erlang:max(T2SellAcc, T2BuyAcc + Price),

            % Update T2Buy: Max profit after buying for the second time.
            %               Either keep the previous max T2Buy, or buy at the current Price
            %               after having made a T1Sell transaction.
            NewT2Buy = erlang:max(T2BuyAcc, T1SellAcc - Price),

            % Update T1Sell: Max profit after selling for the first time.
            %                Either keep the previous max T1Sell, or sell at the current Price
            %                after having made a T1Buy transaction.
            NewT1Sell = erlang:max(T1SellAcc, T1BuyAcc + Price),

            % Update T1Buy: Max profit after buying for the first time.
            %               Either keep the previous max T1Buy, or buy at the current Price.
            NewT1Buy = erlang:max(T1BuyAcc, -Price),

            {NewT1Buy, NewT1Sell, NewT2Buy, NewT2Sell}
        end,
        {-1000000000, 0, -1000000000, 0}, % Initial state {T1Buy, T1Sell, T2Buy, T2Sell}
        Prices
    ),
    FinalT2Sell.