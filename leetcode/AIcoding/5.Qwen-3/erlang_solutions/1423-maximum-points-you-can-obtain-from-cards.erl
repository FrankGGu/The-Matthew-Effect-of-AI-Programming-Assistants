-module(max_points).
-export([max_score/1]).

max_score(Deck) ->
    N = length(Deck),
    K = N div 2,
    lists:foldl(fun(I, Acc) -> max(Acc, sum_k(Deck, I)) end, 0, lists:seq(0, K)).

sum_k(Deck, K) ->
    sum_k(Deck, K, 0).

sum_k([], _, Acc) -> Acc;
sum_k([H | T], K, Acc) when K > 0 ->
    sum_k(T, K - 1, Acc + H);
sum_k([H | T], K, Acc) ->
    sum_k(T, K, Acc + H).