-module(solution).
-export([buy_chocolates/2]).

buy_chocolates(Prices, Money) ->
    SortedPrices = lists:sort(Prices),
    case SortedPrices of
        [P1, P2 | _] ->
            Cost = P1 + P2,
            if Cost =< Money ->
                   Money - Cost;
               true ->
                   Money
            end;
        _ ->
            Money
    end.