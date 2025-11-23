-module(solution).
-export([minimize_total_price/2]).

minimize_total_price(Trips, Discounted) ->
    Trips1 = lists:map(fun({X, Y}) -> {X, Y, 0} end, Trips),
    minimize(Trips1, Discounted).

minimize(Trips, Discounted) ->
    {TotalPrice, _} = lists:foldl(fun({Cost, Count, DiscountedCount}, {Acc, TotalDiscounted}) ->
        NewAcc = Acc + Cost * (Count - TotalDiscounted),
        NewTotalDiscounted = TotalDiscounted + DiscountedCount,
        {NewAcc, NewTotalDiscounted}
    end, {0, 0}, Trips),
    TotalPrice.