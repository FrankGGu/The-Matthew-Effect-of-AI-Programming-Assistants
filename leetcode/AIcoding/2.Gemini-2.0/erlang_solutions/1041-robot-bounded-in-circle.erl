-module(robot_bounded_in_circle).
-export([is_robot_bounded/1]).

is_robot_bounded(Instructions) ->
  {X, Y, Dir} = simulate(Instructions, 0, 0, 0),
  (X == 0 and Y == 0) or Dir /= 0.

simulate([], X, Y, Dir) ->
  {X, Y, Dir};
simulate([H|T], X, Y, Dir) ->
  {NewX, NewY, NewDir} = move(H, X, Y, Dir),
  simulate(T, NewX, NewY, NewDir).

move(G, X, Y, Dir) ->
  case Dir of
    0 -> {X, Y+1, Dir}; % North
    1 -> {X+1, Y, Dir}; % East
    2 -> {X, Y-1, Dir}; % South
    3 -> {X-1, Y, Dir}  % West
  end;
move(L, X, Y, Dir) ->
  {X, Y, (Dir + 3) rem 4};
move(R, X, Y, Dir) ->
  {X, Y, (Dir + 1) rem 4}.