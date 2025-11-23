-spec robot(Commands :: unicode:unicode_binary(), Obstacles :: [[integer()]], X :: integer(), Y :: integer()) -> boolean().
robot(Commands, Obstacles, X, Y) ->
    Dir = [{1, 0}, {0, 1}, {-1, 0}, {0, -1}],
    ObstacleSet = sets:from_list([{OX, OY} || [OX, OY] <- Obstacles]),
    {DX, DY} = lists:foldl(fun
        ($G, {DX, DY}) -> {DX, DY};
        ($L, {DX, DY}) -> {DY, -DX};
        ($R, {DX, DY}) -> {-DY, DX}
    end, {1, 0}, binary_to_list(Commands)),
    Steps = length([C || C <- binary_to_list(Commands), C == $G]),
    MaxSteps = max(abs(X), abs(Y)) * 2,
    check(0, 0, DX, DY, Steps, X, Y, MaxSteps, ObstacleSet).

check(X, Y, _, _, _, X, Y, _, _) -> true;
check(_, _, _, _, 0, _, _, _, _) -> false;
check(CX, CY, DX, DY, Steps, X, Y, MaxSteps, ObstacleSet) ->
    NX = CX + DX,
    NY = CY + DY,
    case sets:is_element({NX, NY}, ObstacleSet) of
        true -> false;
        false -> check(NX, NY, DX, DY, Steps - 1, X, Y, MaxSteps, ObstacleSet)
    end.