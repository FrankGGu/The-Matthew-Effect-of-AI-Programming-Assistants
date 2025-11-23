-module(minimum_operations).
-export([minimum_operations/1]).

minimum_operations(Nums) ->
  minimum_operations(Nums, 0, 0).

minimum_operations([], _, Count) ->
  Count;
minimum_operations([H|T], Current, Count) ->
  Diff = H - Current,
  if Diff > 0 ->
    minimum_operations(T, H, Count + 1);
  true ->
    minimum_operations(T, H, Count)
  end.