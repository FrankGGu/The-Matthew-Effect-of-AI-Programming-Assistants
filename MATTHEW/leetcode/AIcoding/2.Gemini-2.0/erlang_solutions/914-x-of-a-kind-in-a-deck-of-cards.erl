-module(x_of_a_kind).
-export([has_groups_size_x/1]).

has_groups_size_x(Deck) ->
  Counts = lists:foldl(fun(Card, Acc) ->
                         maps:update_with(Card, fun(Count) -> Count + 1 end, 1, Acc)
                       end, #{}, Deck),
  Values = maps:values(Counts),
  GCD = lists:foldl(fun(X, Y) -> gcd(X, Y) end, lists:nth(1, Values), lists:sublist(Values, 2)),
  GCD >= 2.

gcd(0, B) -> B;
gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).