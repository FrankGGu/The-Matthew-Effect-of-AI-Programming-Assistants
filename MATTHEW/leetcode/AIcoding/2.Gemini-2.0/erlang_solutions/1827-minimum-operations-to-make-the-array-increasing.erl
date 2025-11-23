-module(minimum_operations).
-export([min_operations/1]).

min_operations(Nums) ->
  min_operations_helper(Nums, 0, 0).

min_operations_helper([], _, Count) ->
  Count;
min_operations_helper([H|T], Prev, Count) ->
  case H =< Prev of
    true ->
      NewH = Prev + 1,
      min_operations_helper(T, NewH, Count + (NewH - H));
    false ->
      min_operations_helper(T, H, Count)
  end.