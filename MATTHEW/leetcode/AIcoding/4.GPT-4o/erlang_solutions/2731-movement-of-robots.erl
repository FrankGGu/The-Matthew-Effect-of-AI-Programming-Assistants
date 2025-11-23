-module(movement_of_robots).
-export([robotSim/2]).

robotSim(Robots, Instructions) ->
    {X, Y, D} = {0, 0, 0},
    robotSim(Robots, Instructions, {X, Y, D}).

robotSim([], [], {X, Y, _}) -> {X, Y};
robotSim([H | T], Instructions, {X, Y, D}) ->
    case H of
        {Direction, Steps} ->
            NewDir = (D + Direction) rem 4,
            NewPos = move(NewDir, Steps, {X, Y}),
            robotSim(T, Instructions, {element(1, NewPos), element(2, NewPos), NewDir});
        {_, _} ->
            robotSim(T, Instructions, {X, Y, D})
    end.

move(0, Steps, {X, Y}) -> {X, Y + Steps};
move(1, Steps, {X, Y}) -> {X + Steps, Y};
move(2, Steps, {X, Y}) -> {X, Y - Steps};
move(3, Steps, {X, Y}) -> {X - Steps, Y}.