-module(solution).
-export([robot_simulation/2]).

robot_simulation(Commands, Obstacles) ->
    ObstacleSet = lists:foldl(fun(O, Acc) -> gb_sets:add({element(1, O), element(2, O)}, Acc) end, gb_sets:empty(), Obstacles),
    simulate(Commands, 0, 0, 0, 0, ObstacleSet).

simulate([], _X, _Y, _Dir, MaxDistSq, _ObstacleSet) ->
    MaxDistSq;
simulate([-2 | RestCommands], X, Y, Dir, MaxDistSq, ObstacleSet) ->
    NewDir = (Dir - 1 + 4) rem 4,
    simulate(RestCommands, X, Y, NewDir, MaxDistSq, ObstacleSet);
simulate([-1 | RestCommands], X, Y, Dir, MaxDistSq, ObstacleSet) ->
    NewDir = (Dir + 1) rem 4,
    simulate(RestCommands, X, Y, NewDir, MaxDistSq, ObstacleSet);
simulate([Steps | RestCommands], X, Y, Dir, MaxDistSq, ObstacleSet) when Steps > 0 ->
    {NewX, NewY, NewMaxDistSq} = move_forward(Steps, X, Y, Dir, MaxDistSq, ObstacleSet),
    simulate(RestCommands, NewX, NewY, Dir, NewMaxDistSq, ObstacleSet).

move_forward(Steps, CurrentX, CurrentY, Dir, CurrentMaxDistSq, ObstacleSet) ->
    DX = {0, 1, 0, -1}, % North, East, South, West
    DY = {1, 0, -1, 0}, % North, East, South, West
    move_forward_helper(Steps, CurrentX, CurrentY, Dir, CurrentMaxDistSq, ObstacleSet, DX, DY).

move_forward_helper(0, X, Y, _Dir, MaxDistSq, _ObstacleSet, _DX, _DY) ->
    {X, Y, MaxDistSq};
move_forward_helper(RemainingSteps, X, Y, Dir, MaxDistSq, ObstacleSet, DX, DY) ->
    DeltaX = element(Dir + 1, DX),
    DeltaY = element(Dir + 1, DY),

    NextX = X + DeltaX,
    NextY = Y + DeltaY,

    case gb_sets:is_member({NextX, NextY}, ObstacleSet) of
        true ->
            {X, Y, MaxDistSq};
        false ->
            NewMaxDistSq = max(MaxDistSq, NextX*NextX + NextY*NextY),
            move_forward_helper(RemainingSteps - 1, NextX, NextY, Dir, NewMaxDistSq, ObstacleSet, DX, DY)
    end.