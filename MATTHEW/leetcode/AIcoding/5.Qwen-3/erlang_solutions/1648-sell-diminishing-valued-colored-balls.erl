-module(sell_diminishing_valued_colored_balls).
-export([sell_balls/1]).

sell_balls(Balls) ->
    sell_balls(Balls, 0).

sell_balls([], _Total) ->
    _Total;
sell_balls([{Color, Quantity} | Rest], Total) ->
    MaxPrice = floor(math:sqrt(Quantity * 2)),
    Price = MaxPrice,
    Count = (MaxPrice * (MaxPrice + 1)) / 2,
    NewTotal = Total + Price * Count,
    sell_balls(Rest, NewTotal).