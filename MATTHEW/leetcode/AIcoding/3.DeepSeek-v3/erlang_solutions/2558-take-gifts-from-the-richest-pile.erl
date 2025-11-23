-module(solution).
-export([pick_gifts/2]).

pick_gifts(Gifts, K) ->
    pick_gifts(Gifts, K, lists:sort(fun(A, B) -> A >= B end, Gifts)).

pick_gifts(Gifts, 0, _) ->
    lists:sum(Gifts);
pick_gifts(Gifts, K, [Max | Rest]) ->
    NewMax = math:sqrt(Max),
    NewGifts = lists:sort(fun(A, B) -> A >= B end, [trunc(NewMax) | Rest]),
    pick_gifts(NewGifts, K - 1, NewGifts).