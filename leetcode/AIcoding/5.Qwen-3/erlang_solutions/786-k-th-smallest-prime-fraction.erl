-module(prime_fraction).
-export([kthSmallest/2]).

kthSmallest(Fraction, K) ->
    List = lists:sort(Fraction),
    lists:nth(K, List).

compare({A, B}, {C, D}) ->
    A * D =< C * B.