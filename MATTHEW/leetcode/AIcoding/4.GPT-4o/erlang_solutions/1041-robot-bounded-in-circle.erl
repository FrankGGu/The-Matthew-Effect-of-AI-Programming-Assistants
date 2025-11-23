-module(robot_bounded_in_circle).
-export([is_robot_bounded/1]).

is_robot_bounded(S) ->
    {X, Y, D} = move({0, 0, 0}, S),
    (X =:= 0 andalso Y =:= 0) orelse (D /= 0).

move({X, Y, D}, []) -> {X, Y, D};
move({X, Y, D}, [H | T]) ->
    case H of
        ?LEFT -> move({X, Y, (D + 3) rem 4}, T);
        ?RIGHT -> move({X, Y, (D + 1) rem 4}, T);
        ?GO -> 
            case D of
                0 -> move({X, Y + 1, D}, T);
                1 -> move({X + 1, Y, D}, T);
                2 -> move({X, Y - 1, D}, T);
                3 -> move({X - 1, Y, D}, T)
            end
    end.

-define(LEFT, $L).
-define(RIGHT, $R).
-define(GO, $G).