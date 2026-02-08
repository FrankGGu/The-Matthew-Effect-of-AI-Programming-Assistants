-module(min_changes_alternating_binary_string).
-export([min_operations/1]).

min_operations(S) ->
  min(count_changes(S, 0), count_changes(S, 1)).

count_changes(S, Start) ->
  count_changes_helper(S, Start, 0).

count_changes_helper([], _, Acc) ->
  Acc;
count_changes_helper([H | T], Expected, Acc) ->
  Bit = list_to_integer([H - $0]),
  NewAcc = case Bit =:= Expected of
    true -> Acc;
    false -> Acc + 1
  end,
  NextExpected = 1 - Expected,
  count_changes_helper(T, NextExpected, NewAcc).