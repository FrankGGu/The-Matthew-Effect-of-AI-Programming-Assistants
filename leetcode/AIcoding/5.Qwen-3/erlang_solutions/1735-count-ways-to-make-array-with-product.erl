-module(solution).
-export([num_ways/1]).

num_ways(Num) ->
    Factors = factorize(Num),
    Count = count_ways(Factors, 0),
    Count.

factorize(N) ->
    factorize(N, 2, []).

factorize(1, _, Acc) ->
    lists:reverse(Acc);
factorize(N, I, Acc) when N rem I == 0 ->
    factorize(N div I, I, [I | Acc]);
factorize(N, I, Acc) ->
    factorize(N, I + 1, Acc).

count_ways([], _) ->
    1;
count_ways([P | Ps], K) ->
    Ways = 0,
    for(1, P, fun(I) -> Ways = Ways + count_ways(Ps, I) end),
    Ways.