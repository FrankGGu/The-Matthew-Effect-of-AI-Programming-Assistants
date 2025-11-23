-module(solution).
-export([max_profit/1]).

max_profit(Prices) ->
    % T1Cost: Minimum cost to buy the first stock.
    % T1Profit: Maximum profit after selling the first stock.
    % T2Cost: Minimum cost to buy the second stock (after completing the first transaction).
    % T2Profit: Maximum profit after selling the second stock.
    InitialState = {float:infinity, 0, float:infinity, 0},

    FinalState = lists:foldl(
        fun(Price, {T1Cost, T1Profit, T2Cost, T2Profit}) ->
            % Update T2Profit: Max profit after selling the second stock.
            % It's the max of current T2Profit or (Price - T2Cost).
            % (Price - T2Cost) represents selling the second stock at current Price.
            NewT2Profit = max(T2Profit, Price - T2Cost),

            % Update T2Cost: Min cost to buy the second stock.
            % It's the min of current T2Cost or (Price - T1Profit).
            % (Price - T1Profit) represents the effective cost of buying the second stock
            % after having made T1Profit from the first transaction.
            NewT2Cost = min(T2Cost, Price - T1Profit),

            % Update T1Profit: Max profit after selling the first stock.
            % It's the max of current T1Profit or (Price - T1Cost).
            % (Price - T1Cost) represents selling the first stock at current Price.
            NewT1Profit = max(T1Profit, Price - T1Cost),

            % Update T1Cost: Min cost to buy the first stock.
            % It's the min of current T1Cost or Price.
            NewT1Cost = min(T1Cost, Price),

            {NewT1Cost, NewT1Profit, NewT2Cost, NewT2Profit}
        end,
        InitialState,
        Prices
    ),

    {_, _, _, ResultT2Profit} = FinalState,
    ResultT2Profit.