-module(lexical_numbers).
-export([lexical_order/1]).

lexical_order(N) ->
  lists:sort(fun(A, B) -> list_to_integer(A) < list_to_integer(B) end, [integer_to_list(I) || I <- lists:seq(1, N)]).