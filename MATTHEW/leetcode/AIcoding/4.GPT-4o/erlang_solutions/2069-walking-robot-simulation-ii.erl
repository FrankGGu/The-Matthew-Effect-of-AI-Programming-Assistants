-module(solution).
-export([robotSim/2]).

robotSim(Moves, Obstacle) ->
    Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
    simulate(Moves, Obstacle, {0, 0}, 0, Directions, 0).

simulate([], _, Position, _, _, MaxDist) -> MaxDist;
simulate([Move | Rest], Obstacle, {X, Y}, DirIndex, Directions, MaxDist) ->
    case Move of
        0 -> 
            NewDirIndex = (DirIndex + 3) rem 4,
            simulate(Rest, Obstacle, {X, Y}, NewDirIndex, Directions, MaxDist);
        1 -> 
            NewDirIndex = (DirIndex + 1) rem 4,
            simulate(Rest, Obstacle, {X, Y}, NewDirIndex, Directions, MaxDist);
        _ -> 
            {DX, DY} = lists:nth(DirIndex + 1, Directions),
            NewPosition = {X + DX * Move, Y + DY * Move},
            if 
                is_obstacle(NewPosition, Obstacle) -> 
                    simulate(Rest, Obstacle, {X, Y}, DirIndex, Directions, MaxDist);
                true -> 
                    NewMaxDist = max(MaxDist, X * X + Y * Y),
                    simulate(Rest, Obstacle, NewPosition, DirIndex, Directions, NewMaxDist)
            end
    end.

is_obstacle({X, Y}, Obstacles) ->
    lists:member({X, Y}, Obstacles).