-module(robot_collisions).
-export([robot_collisions/3]).

robot_collisions(Positions, Healths, Directions) ->
  N = length(Positions),
  Robots = lists:zip3(Positions, Healths, Directions),
  SortedRobots = lists:keysort(1, lists:seq(1, N, Robots)),
  Stack = [],
  Result = [],
  Remaining = lists:seq(1, N),

  process_robots(SortedRobots, Stack, Result, Remaining).

process_robots([], Stack, Result, Remaining) ->
  lists:sort([ {Pos, Health} || {Pos, Health, _} <- Result ++ Stack]);

process_robots([{Pos, Health, Dir} | Rest], Stack, Result, Remaining) ->
  case Dir of
    'R' ->
      process_robots(Rest, [{Pos, Health, Dir} | Stack], Result, Remaining);
    'L' ->
      case Stack of
        [] ->
          process_robots(Rest, Stack, Result ++ [{Pos, Health, Dir}], Remaining);
        [{StackPos, StackHealth, 'R'} | RestStack] ->
          if Health > StackHealth then
            process_robots(Rest, RestStack, Result, Remaining -- [StackPos]),
            process_robots([{Pos, Health - 1, Dir} | Rest], RestStack, Result, Remaining)
          else if Health < StackHealth then
            process_robots(Rest, [{StackPos, StackHealth - 1, 'R'} | RestStack], Result, Remaining -- [Pos])
          else
            process_robots(Rest, RestStack, Result, Remaining -- [Pos, StackPos])
          end
      end
  end.