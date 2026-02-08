-module(find_maximum_length_of_a_good_subsequence_ii).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, []).

solve([], Acc) ->
  length(Acc);
solve([H|T], Acc) ->
  case is_good(H, Acc) of
    true ->
      solve(T, insert_sorted(H, Acc));
    false ->
      solve(T, Acc)
  end.

is_good(Num, []) ->
  true;
is_good(Num, [H|_]) when Num rem H == 0 ->
  false;
is_good(Num, _) ->
  true.

insert_sorted(Num, []) ->
  [Num];
insert_sorted(Num, [H|T]) when Num < H ->
  [Num, H | T];
insert_sorted(Num, [H|T]) ->
  [H | insert_sorted(Num, T)].