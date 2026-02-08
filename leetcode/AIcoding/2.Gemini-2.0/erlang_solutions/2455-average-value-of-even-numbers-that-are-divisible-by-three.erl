-module(average_even_divisible_by_three).
-export([average_value/1]).

average_value(Nums) ->
  F = fun(X) -> (X rem 2 == 0) and (X rem 3 == 0) end,
  Filtered = lists:filter(F, Nums),
  Len = length(Filtered),
  if Len == 0 ->
    0;
  true ->
    Sum = lists:sum(Filtered),
    round(Sum / Len)
  end.