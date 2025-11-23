-module(min_operations).
-export([min_operations/1]).

min_operations(Nums) ->
  min_operations(Nums, 0, []).

min_operations([], Acc, _) ->
  Acc;
min_operations([H|T], Acc, Seen) ->
  case lists:member(H, Seen) of
    true ->
      min_operations([H + 1|T], Acc + 1, Seen ++ [H + 1]);
    false ->
      min_operations(T, Acc, Seen ++ [H])
  end.