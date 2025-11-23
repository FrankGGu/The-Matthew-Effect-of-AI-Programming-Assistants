-module(odd_even_linked_list).
-export([odd_even_list/1]).

-spec odd_even_list(list()) -> list().
odd_even_list(L) ->
  odd_even_list(L, [], []).

odd_even_list([], Odds, Evens) ->
  lists:reverse(Odds) ++ lists:reverse(Evens);
odd_even_list([H|T], Odds, Evens) ->
  odd_even_list(T, [H|Evens], Odds);
odd_even_list([H1,H2|T], Odds, Evens) ->
  odd_even_list(T, [H1|Odds], [H2|Evens]).