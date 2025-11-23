-module(solution).
-export([minimum_coins/1]).

minimum_coins(Prices) ->
    N = length(Prices),
    DP = lists:duplicate(N + 2, 0),
    {Result, _} = lists:foldl(fun(I, {Dp, _}) ->
        MinCost = lists:min([lists:nth(J + 1, Dp) || J <- lists:seq(max(0, I - 2), I - 1)]),
        NewDp = setelement(I + 1, Dp, MinCost + lists:nth(I, Prices)),
        {NewDp, I}
    end, {DP, 0}, lists:seq(1, N)),
    lists:nth(N + 1, Result).