-module(max_enemy_forts).
-export([max_captured_forts/1]).

max_captured_forts(Forts) ->
  max_captured_forts_helper(Forts, 0, 0, 0).

max_captured_forts_helper([], Max, _, _) ->
  Max;
max_captured_forts_helper([0|Rest], Max, Start, Dir) ->
  max_captured_forts_helper(Rest, Max, Start, Dir);
max_captured_forts_helper([1|Rest], Max, 0, _) ->
  max_captured_forts_helper(Rest, Max, 1, 0);
max_captured_forts_helper([1|Rest], Max, 1, _) ->
  max_captured_forts_helper(Rest, Max, 1, 0);
max_captured_forts_helper([1|Rest], Max, -1, Dir) ->
  Captured = lists:seq(1, Dir) -- [1],
  max_captured_forts_helper(Rest, max(Max, length(Captured)), 1, 0);
max_captured_forts_helper([-1|Rest], Max, 0, _) ->
  max_captured_forts_helper(Rest, Max, -1, 0);
max_captured_forts_helper([-1|Rest], Max, -1, _) ->
  max_captured_forts_helper(Rest, Max, -1, 0);
max_captured_forts_helper([-1|Rest], Max, 1, Dir) ->
  Captured = lists:seq(1, Dir) -- [1],
  max_captured_forts_helper(Rest, max(Max, length(Captured)), -1, 0);
max_captured_forts_helper([X|Rest], Max, Start, Dir) when Start > 0 ->
  max_captured_forts_helper(Rest, Max, Start, Dir + 1);
max_captured_forts_helper([X|Rest], Max, Start, Dir) when Start < 0 ->
  max_captured_forts_helper(Rest, Max, Start, Dir + 1).