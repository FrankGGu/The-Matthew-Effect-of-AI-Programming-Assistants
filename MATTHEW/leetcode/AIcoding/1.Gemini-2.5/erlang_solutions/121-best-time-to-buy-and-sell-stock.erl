-module(solution).
-export([max_profit/1]).

max_profit([]) -> 0;
max_profit([_Price]) -> 0;
max_profit([FirstPrice | RestPrices]) ->
    {_MinPrice, MaxProfit} = lists:foldl(
        fun(Price, {CurrentMinPrice, CurrentMaxProfit}) ->
            NewMinPrice = min(CurrentMinPrice, Price),
            NewMaxProfit = max(CurrentMaxProfit, Price - CurrentMinPrice),
            {NewMinPrice, NewMaxProfit}
        end,
        {FirstPrice, 0},
        RestPrices
    ),
    MaxProfit.