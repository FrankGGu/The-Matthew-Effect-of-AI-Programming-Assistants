-module(solution).
-export([count_target/2]).

count_target(Nums, Target) ->
  count_target(Nums, Target, 0).

count_target([], _, Count) ->
  Count;
count_target([H | T], Target, Count) ->
  if
    H =:= Target ->
      count_target(T, Target, Count + 1);
    true ->
      count_target(T, Target, Count)
  end.