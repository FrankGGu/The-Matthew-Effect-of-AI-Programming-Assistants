-module(robot_bounded_in_circle).
-export([is_robot_bounded/1]).

is_robot_bounded(Instructions) ->
    {X, Y, Dir} = move(Instructions, 0, 0, 0),
    (X == 0 andalso Y == 0) orelse Dir /= 0.

move([], X, Y, Dir) ->
    {X, Y, Dir};
move([H|T], X, Y, Dir) ->
    case H of
        $L -> move(T, X, Y, (Dir - 1 + 4) rem 4);
        $R -> move(T, X, Y, (Dir + 1) rem 4);
        $G ->
            NewX = case Dir of
                       0 -> X + 1;
                       1 -> X;
                       2 -> X - 1;
                       3 -> X
                   end,
            NewY = case Dir of
                       0 -> Y;
                       1 -> Y + 1;
                       2 -> Y;
                       3 -> Y - 1
                   end,
            move(T, NewX, NewY, Dir)
    end.