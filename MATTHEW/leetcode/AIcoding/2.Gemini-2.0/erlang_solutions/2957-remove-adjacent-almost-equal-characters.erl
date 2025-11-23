-module(remove_adjacent_almost_equal).
-export([min_operations/1]).

min_operations(S) ->
  min_operations_helper(S, 0).

min_operations_helper([], Count) ->
  Count;
min_operations_helper([H], Count) ->
  Count;
min_operations_helper([H1, H2 | T], Count) ->
  Diff = abs(H1 - H2),
  if
    Diff =< 1 ->
      min_operations_helper([H2 | T], Count + 1);
    true ->
      min_operations_helper([H2 | T], Count)
  end.