-module(minimum_increments).
-export([min_increments/1]).

min_increments(Nums) ->
  min_increments(Nums, 0, []).

min_increments([], Acc, _) ->
  Acc;
min_increments([H|T], Acc, Seen) ->
  case lists:member(H, Seen) of
    true ->
      min_increments([H+1|T], Acc+1, Seen ++ [H+1]);
    false ->
      min_increments(T, Acc, Seen ++ [H])
  end.