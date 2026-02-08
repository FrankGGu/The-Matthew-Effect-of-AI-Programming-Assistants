-spec robot_sim(Commands :: [integer()], Obstacles :: [[integer()]]) -> integer().
robot_sim(Commands, Obstacles) ->
    ObstacleSet = sets:from_list([{X, Y} || [X, Y] <- Obstacles]),
    Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
    {X, Y, Dir, Max} = lists:foldl(fun
        (-1, {X0, Y0, Dir0, Max0}) ->
            NewDir = (Dir0 - 1) rem 4,
            {X0, Y0, (if NewDir < 0 -> NewDir + 4; true -> NewDir end), Max0};
        (-2, {X0, Y0, Dir0, Max0}) ->
            NewDir = (Dir0 + 1) rem 4,
            {X0, Y0, NewDir, Max0};
        (Steps, {X0, Y0, Dir0, Max0}) ->
            {Dx, Dy} = lists:nth(Dir0 + 1, Directions),
            {NewX, NewY} = move(X0, Y0, Dx, Dy, Steps, ObstacleSet),
            Distance = NewX * NewX + NewY * NewY,
            NewMax = if Distance > Max0 -> Distance; true -> Max0 end,
            {NewX, NewY, Dir0, NewMax}
    end, {0, 0, 0, 0}, Commands),
    Max.

move(X, Y, Dx, Dy, Steps, ObstacleSet) ->
    move(X, Y, Dx, Dy, Steps, ObstacleSet, Steps).

move(X, Y, _, _, 0, _, _) -> {X, Y};
move(X, Y, Dx, Dy, Steps, ObstacleSet, TotalSteps) ->
    NextX = X + Dx,
    NextY = Y + Dy,
    case sets:is_element({NextX, NextY}, ObstacleSet) of
        true -> {X, Y};
        false -> move(NextX, NextY, Dx, Dy, Steps - 1, ObstacleSet, TotalSteps)
    end.