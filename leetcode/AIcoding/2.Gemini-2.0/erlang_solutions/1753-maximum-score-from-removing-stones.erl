-module(maximum_score).
-export([maximum_score/1]).

maximum_score([A, B, C]) ->
  maximum_score_helper(A, B, C).

maximum_score_helper(A, B, C) ->
  lists:max([maximum_score_helper_sorted([A,B,C])]).

maximum_score_helper_sorted([A, B, C]) ->
  Sorted = lists:sort([A, B, C], fun(X, Y) -> X > Y end),
  [X, Y, Z] = Sorted,
  if
    Y == 0 orelse Z == 0 ->
      0;
    true ->
      Y + Z
  end.