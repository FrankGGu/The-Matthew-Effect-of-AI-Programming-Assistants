-module(solution).
-export([robotSim/2]).

robotSim(Moves, Obstacle) ->
    {X, Y, Dir} = robotSimHelper(Moves, Obstacle, {0, 0, 0}),
    X * X + Y * Y.

robotSimHelper([], _, {X, Y, _}) -> {X, Y};
robotSimHelper([Move | Rest], Obstacle, {X, Y, Dir}) ->
    case Move of
        -1 -> robotSimHelper(Rest, Obstacle, {X, Y, (Dir + 1) rem 4});
        1 -> robotSimHelper(Rest, Obstacle, move({X, Y, Dir}, Obstacle));
        _ -> robotSimHelper(Rest, Obstacle, {X, Y, Dir})
    end.

move({X, Y, 0}, _) -> {X + 1, Y}; % North
move({X, Y, 1}, _) -> {X, Y + 1}; % East
move({X, Y, 2}, Obstacles) ->
    case lists:member({X - 1, Y}, Obstacles) of
        true -> {X, Y};
        false -> {X - 1, Y}
    end; % South
move({X, Y, 3}, Obstacles) ->
    case lists:member({X, Y - 1}, Obstacles) of
        true -> {X, Y};
        false -> {X, Y - 1}
    end. % West