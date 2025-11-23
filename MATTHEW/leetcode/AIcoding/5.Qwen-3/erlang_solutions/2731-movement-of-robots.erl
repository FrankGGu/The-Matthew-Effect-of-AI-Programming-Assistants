-module(robots_movement).
-export([robot_sim/2]).

robot_sim(Robots, Commands) ->
    robot_sim(Robots, Commands, 0, 0, 0).

robot_sim([], _, X, Y, _) ->
    {X, Y};
robot_sim([Robot | Rest], Commands, X, Y, Dir) ->
    {NewX, NewY, NewDir} = move_robot(Robot, Commands, X, Y, Dir),
    robot_sim(Rest, Commands, NewX, NewY, NewDir).

move_robot(_, [], X, Y, Dir) ->
    {X, Y, Dir};
move_robot({X, Y, Dir}, [C | Cs], X, Y, Dir) ->
    move_robot({X, Y, Dir}, Cs, X, Y, Dir);
move_robot({X, Y, Dir}, [C | Cs], OldX, OldY, OldDir) ->
    case C of
        'L' ->
            NewDir = (OldDir - 90 + 360) rem 360,
            move_robot({OldX, OldY, NewDir}, Cs, OldX, OldY, NewDir);
        'R' ->
            NewDir = (OldDir + 90) rem 360,
            move_robot({OldX, OldY, NewDir}, Cs, OldX, OldY, NewDir);
        'G' ->
            {NewX, NewY} = move_forward(OldX, OldY, OldDir),
            move_robot({NewX, NewY, OldDir}, Cs, NewX, NewY, OldDir)
    end.

move_forward(X, Y, 0) ->
    {X, Y + 1};
move_forward(X, Y, 90) ->
    {X + 1, Y};
move_forward(X, Y, 180) ->
    {X, Y - 1};
move_forward(X, Y, 270) ->
    {X - 1, Y}.