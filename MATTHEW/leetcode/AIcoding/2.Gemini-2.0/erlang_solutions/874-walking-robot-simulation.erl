-module(walking_robot_simulation).
-export([robotSim/2]).

robotSim(Commands, Obstacles) ->
  robotSim(Commands, Obstacles, 0, 0, 0, 0).

robotSim([], _, MaxDist, _, _, _) ->
  MaxDist;
robotSim([Command | Rest], Obstacles, MaxDist, X, Y, Dir) ->
  case Command of
    -2 ->
      NewDir = (Dir + 1) rem 4;
      robotSim(Rest, Obstacles, MaxDist, X, Y, NewDir);
    -1 ->
      NewDir = (Dir + 3) rem 4;
      robotSim(Rest, Obstacles, MaxDist, X, Y, NewDir);
    Dist ->
      {NewX, NewY, NewMaxDist} = move(Dist, Dir, X, Y, Obstacles, MaxDist);
      robotSim(Rest, Obstacles, NewMaxDist, NewX, NewY, Dir)
  end.

move(0, _, X, Y, _, MaxDist) ->
  {X, Y, MaxDist};
move(Dist, Dir, X, Y, Obstacles, MaxDist) ->
  {NewX, NewY} = next_position(X, Y, Dir),
  case is_obstacle(NewX, NewY, Obstacles) of
    true ->
      {X, Y, MaxDist};
    false ->
      NewMaxDist = max(MaxDist, NewX * NewX + NewY * NewY),
      move(Dist - 1, Dir, NewX, NewY, Obstacles, NewMaxDist)
  end.

next_position(X, Y, 0) ->
  {X, Y + 1};
next_position(X, Y, 1) ->
  {X + 1, Y};
next_position(X, Y, 2) ->
  {X, Y - 1};
next_position(X, Y, 3) ->
  {X - 1, Y}.

is_obstacle(X, Y, Obstacles) ->
  lists:member({X, Y}, Obstacles).