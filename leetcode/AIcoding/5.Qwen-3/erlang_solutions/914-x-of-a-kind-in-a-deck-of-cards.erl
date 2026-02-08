-module(deck_of_cards).
-export([has_groups_size_x/1]).

has_groups_sizeX(Deck) ->
    Count = lists:foldl(fun(X, Acc) -> dict:update_counter(X, 1, Acc) end, dict:new(), Deck),
    Values = dict:values(Count),
    GCD = lists:foldl(fun gcd/2, lists:nth(1, Values), tl(Values)),
    lists:all(fun(V) -> V rem GCD == 0 end, Values).

gcd(A, B) when A < B -> gcd(B, A);
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).