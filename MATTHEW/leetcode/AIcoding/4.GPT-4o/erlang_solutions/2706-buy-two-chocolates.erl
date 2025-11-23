-module(solution).
-export([buy_two_chocolates/1]).

buy_two_chocolates(Prices) ->
    SortedPrices = lists:sort(Prices),
    case lists:split(2, SortedPrices) of
        {Smallest, [_ | Rest]} ->
            lists:sum(Smallest) + hd(Rest);
        _ ->
            0
    end.