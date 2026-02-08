-module(maximize_profit).
-export([solve/1]).

solve(Offers) ->
    solve(Offers, 0, 0).

solve([], _Position, MaxProfit) ->
    MaxProfit;
solve([Offer | Rest], Position, MaxProfit) ->
    {Start, End, Price} = Offer,
    if Position =< Start orelse Position > End then
        solve(Rest, Position, MaxProfit)
    else
        ProfitWithOffer = solve(Rest, End + 1, MaxProfit + Price),
        ProfitWithoutOffer = solve(Rest, Position, MaxProfit),
        solve([], 0, max(ProfitWithOffer, ProfitWithoutOffer))
    end.