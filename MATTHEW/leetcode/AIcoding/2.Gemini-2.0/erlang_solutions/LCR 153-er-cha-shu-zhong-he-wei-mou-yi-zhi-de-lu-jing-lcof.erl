-module(solution).
-export([has_path_sum/2]).

has_path_sum(null, _) -> false;
has_path_sum({Val, null, null}, Sum) -> Val =:= Sum;
has_path_sum({Val, Left, Right}, Sum) ->
  NewSum = Sum - Val,
  has_path_sum(Left, NewSum) orelse has_path_sum(Right, NewSum).