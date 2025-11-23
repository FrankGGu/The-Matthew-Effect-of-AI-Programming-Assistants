-module(walking_robot_simulation).
-export([robot_sim/2]).

robot_sim(Instructions, Obstacles) ->
    Directions = [{0,1}, {1,0}, {0,-1}, {-1,0}],
    {X, Y, Dir, MaxDist} = simulate(0, 0, 0, 0, Instructions, Directions, Obstacles),
    MaxDist.

simulate(X, Y, Dir, MaxDist, [], _Directions, _Obstacles) ->
    {X, Y, Dir, MaxDist};
simulate(X, Y, Dir, MaxDist, [H|T], Directions, Obstacles) ->
    case H of
        1 -> 
            NewDir = (Dir + 1) rem 4,
            simulate(X, Y, NewDir, MaxDist, T, Directions, Obstacles);
        -1 ->
            NewDir = (Dir + 3) rem 4,
            simulate(X, Y, NewDir, MaxDist, T, Directions, Obstacles);
        _ ->
            {DX, DY} = lists:nth(Dir + 1, Directions),
            NewX = X + DX,
            NewY = Y + DY,
            if
                lists:member({NewX, NewY}, Obstacles) ->
                    simulate(X, Y, Dir, MaxDist, T, Directions, Obstacles);
                true ->
                    NewMaxDist = max(MaxDist, NewX * NewX + NewY * NewY),
                    simulate(NewX, NewY, Dir, NewMaxDist, T, Directions, Obstacles)
            end
    end.