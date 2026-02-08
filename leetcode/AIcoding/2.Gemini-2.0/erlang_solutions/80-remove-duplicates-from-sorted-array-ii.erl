-module(remove_duplicates).
-export([removeDuplicates/1]).

removeDuplicates(Nums) ->
  removeDuplicates(Nums, []).

removeDuplicates([], Acc) ->
  lists:reverse(Acc);
removeDuplicates([H|T], Acc) ->
  removeDuplicates(T, remove(H, T, Acc)).

remove(H, [], Acc) ->
  [H | lists:reverse(Acc)];
remove(H, [H1|T], Acc) ->
  case H =:= H1 of
    true ->
      remove2(H, H, T, Acc);
    false ->
      [H | lists:reverse(Acc)]
  end.

remove2(H, Prev, [], Acc) ->
  [H, Prev | lists:reverse(Acc)];
remove2(H, Prev, [H1|T], Acc) ->
  case H =:= H1 of
    true ->
      [H, Prev | lists:reverse(Acc)];
    false ->
      [H, Prev | lists:reverse(Acc)]
  end.