-module(robot_collisions).
-export([count_collisions/1]).

count_collisions(Robots) ->
    count_collisions(Robots, []).

count_collisions([], Acc) ->
    length(Acc);
count_collisions([H | T], Acc) ->
    case Acc of
        [] ->
            count_collisions(T, [H]);
        _ ->
            case H of
                {Pos, Dir, Id} when Dir == right ->
                    count_collisions(T, [H | Acc]);
                {Pos, Dir, Id} when Dir == left ->
                    case lists:reverse(Acc) of
                        [] ->
                            count_collisions(T, [H | Acc]);
                        [Last | _] when Last#robot.pos > Pos ->
                            count_collisions(T, [H | Acc]);
                        [Last | Rest] when Last#robot.pos < Pos ->
                            NewAcc = [H | Rest],
                            count_collisions(T, NewAcc);
                        [Last | Rest] when Last#robot.pos == Pos ->
                            count_collisions(T, [H | Rest])
                    end
            end
    end.

-record(robot, {pos, dir, id}).