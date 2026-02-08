-module(solution).
-export([countHouses/2]).

countHouses(N, K) ->
    mod_count_houses(N, K, 1000000007).

mod_count_houses(0, _K, _Mod) -> 1;
mod_count_houses(N, K, Mod) -> 
    P = K,
    Q = (K - 1) * (K - 1) rem Mod,
    lists:foldl(fun(_, {Prev, Curr}) -> {Curr, (Prev * P + Curr * Q) rem Mod} end, {1, 0}, lists:seq(1, N - 1))#Curr.