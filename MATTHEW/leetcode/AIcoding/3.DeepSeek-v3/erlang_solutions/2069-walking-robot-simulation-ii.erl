-module(walking_robot_simulation_ii).
-export([init/4, step/2, getPos/1, getDir/1]).

-record(robot, {
    width,
    height,
    x,
    y,
    dir,
    perimeter
}).

init(Width, Height, X, Y) ->
    Perimeter = 2 * (Width + Height - 2),
    #robot{
        width = Width,
        height = Height,
        x = X,
        y = Y,
        dir = "East",
        perimeter = Perimeter
    }.

step(Robot, Num) ->
    if
        Num == 0 -> Robot;
        true ->
            #robot{
                width = Width,
                height = Height,
                x = X,
                y = Y,
                dir = Dir,
                perimeter = Perimeter
            } = Robot,
            Steps = Num rem Perimeter,
            if
                Steps == 0 -> Robot;
                true ->
                    {NewX, NewY, NewDir} = move(Robot, Steps),
                    Robot#robot{
                        x = NewX,
                        y = NewY,
                        dir = NewDir
                    }
            end
    end.

move(Robot, Steps) ->
    move(Robot, Steps, 0).

move(Robot, Steps, Acc) when Acc < Steps ->
    #robot{
        width = Width,
        height = Height,
        x = X,
        y = Y,
        dir = Dir
    } = Robot,
    case Dir of
        "East" ->
            if
                X + 1 < Width ->
                    move(Robot#robot{x = X + 1}, Steps, Acc + 1);
                true ->
                    move(Robot#robot{dir = "North"}, Steps, Acc)
            end;
        "North" ->
            if
                Y + 1 < Height ->
                    move(Robot#robot{y = Y + 1}, Steps, Acc + 1);
                true ->
                    move(Robot#robot{dir = "West"}, Steps, Acc)
            end;
        "West" ->
            if
                X - 1 >= 0 ->
                    move(Robot#robot{x = X - 1}, Steps, Acc + 1);
                true ->
                    move(Robot#robot{dir = "South"}, Steps, Acc)
            end;
        "South" ->
            if
                Y - 1 >= 0 ->
                    move(Robot#robot{y = Y - 1}, Steps, Acc + 1);
                true ->
                    move(Robot#robot{dir = "East"}, Steps, Acc)
            end
    end;
move(Robot, _Steps, _Acc) ->
    #robot{x = X, y = Y, dir = Dir} = Robot,
    {X, Y, Dir}.

getPos(Robot) ->
    #robot{x = X, y = Y} = Robot,
    [X, Y].

getDir(Robot) ->
    #robot{dir = Dir} = Robot,
    Dir.