-module(robot).
-export([new/2, step/2, get_pos/1]).

-record(robot, {
    x,
    y,
    dir,
    width,
    height,
    perimeter,
    has_moved % true if step(N > 0) has been called, false otherwise
}).

new(Width, Height) ->
    Perimeter = 2 * (Width - 1) + 2 * (Height - 1),
    #robot{x=0, y=0, dir=east, width=Width, height=Height, perimeter=Perimeter, has_moved=false}.

step(Robot, Num) ->
    #{x:=_X, y:=_Y, dir:=_Dir, width:=_W, height:=_H, perimeter:=P, has_moved:=_HasMoved} = Robot,

    if Num == 0 ->
        Robot;
    true ->
        if P == 0 ->
            Robot#robot{has_moved=true};
        true ->
            EffectiveSteps = Num rem P,
            ActualStepsToMove = if EffectiveSteps == 0 -> P; true -> EffectiveSteps end,

            NewRobot = lists:foldl(fun(_, AccRobot) -> move_one_step(AccRobot) end, Robot, lists:seq(1, ActualStepsToMove)),
            NewRobot#robot{has_moved=true}
        end
    end.

get_pos(Robot) ->
    {[Robot#robot.x, Robot#robot.y], Robot#robot.dir}.

move_one_step(Robot) ->
    #{x:=X, y:=Y, dir:=Dir, width:=W, height:=H} = Robot,

    {NewX, NewY, NewDir} = case Dir of
        east ->
            if X < W-1 -> {X+1, Y, east};
            true ->
                if H == 1 -> {X-1, Y, west};
                true -> {X, Y+1, north}
                end
            end;
        north ->
            if Y < H-1 -> {X, Y+1, north};
            true ->
                if W == 1 -> {X, Y-1, south};
                true -> {X-1, Y, west}
                end
            end;
        west ->
            if X > 0 -> {X-1, Y, west};
            true ->
                if H == 1 -> {X+1, Y, east};
                true -> {X, Y-1, south}
                end
            end;
        south ->
            if Y > 0 -> {X, Y-1, south};
            true ->
                if W == 1 -> {X, Y+1, north};
                true -> {X+1, Y, east}
                end
            end
    end,

    Robot#robot{x=NewX, y=NewY, dir=NewDir}.