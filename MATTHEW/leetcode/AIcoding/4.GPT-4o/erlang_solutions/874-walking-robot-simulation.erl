-module(solution).
-export([robotSim/2]).

robotSim(Moves, Obstacles) ->
    Direction = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
    InitialState = {0, 0, 0, 0},
    ObstacleSet = sets:from_list(Obstacles),
    lists:foldl(fun(Move, {X, Y, Dir, Max}) ->
        case Move of
            0 -> 
                {X + element(1, lists:nth(Dir + 1, Direction)), Y + element(2, lists:nth(Dir + 1, Direction)), Dir, Max};
            1 -> 
                {X, Y, (Dir + 1) rem 4, Max};
            2 -> 
                {X, Y, (Dir + 3) rem 4, Max}
        end
    end, InitialState, Moves).