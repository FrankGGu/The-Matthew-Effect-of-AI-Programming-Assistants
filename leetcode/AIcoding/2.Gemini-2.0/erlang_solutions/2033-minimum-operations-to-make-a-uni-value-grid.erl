-module(minimum_operations).
-export([min_operations/2]).

min_operations(Grid, X) ->
  Nums = lists:flatten(Grid),
  case check_valid(Nums, X) of
    true ->
      min_ops(Nums, X);
    false ->
      -1
  end.

check_valid(Nums, X) ->
  case Nums of
    [] ->
      true;
    [H | T] ->
      lists:all(fun(N) -> (abs(N - H) rem X) == 0 end, T)
  end.

min_ops(Nums, X) ->
  Sorted = lists:sort(Nums),
  Len = length(Sorted),
  Median = lists:nth(Len div 2 + 1, Sorted),
  lists:sum([abs(N - Median) div X || N <- Sorted]).