-module(smallest_integer_divisible_by_k).
-export([smallestRepunitDivByK/1]).

smallestRepunitDivByK(K) ->
  smallestRepunitDivByK(K, 1, 1, []).

smallestRepunitDivByK(K, N, Rem, Seen) ->
  if
    Rem == 0 ->
      N;
    lists:member(Rem, Seen) ->
      -1;
    true ->
      NewRem = (Rem * 10 + 1) rem K,
      smallestRepunitDivByK(K, N + 1, NewRem, [Rem | Seen])
  end.