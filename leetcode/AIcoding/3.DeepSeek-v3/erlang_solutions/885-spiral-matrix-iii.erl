-spec spiral_matrix_iii(Rows :: integer(), Cols :: integer(), RStart :: integer(), CStart :: integer()) -> [[integer()]].
spiral_matrix_iii(Rows, Cols, RStart, CStart) ->
    Directions = [{0, 1}, {1, 0}, {0, -1}, {-1, 0}],
    spiral(Rows, Cols, RStart, CStart, Directions, 0, 1, 0, []).

spiral(Rows, Cols, R, C, _Directions, _DirIndex, _Step, _Count, Acc) when length(Acc) =:= Rows * Cols ->
    lists:reverse(Acc);
spiral(Rows, Cols, R, C, Directions, DirIndex, Step, Count, Acc) ->
    case {R >= 0, R < Rows, C >= 0, C < Cols} of
        {true, true, true, true} ->
            NewAcc = [[R, C] | Acc],
            NewCount = Count + 1;
        _ ->
            NewAcc = Acc,
            NewCount = Count
    end,
    if
        Count =:= Step ->
            NewDirIndex = (DirIndex + 1) rem 4,
            {DR, DC} = lists:nth(NewDirIndex + 1, Directions),
            NewStep = case NewDirIndex rem 2 of
                0 -> Step + 1;
                1 -> Step
            end,
            NewR = R + DR,
            NewC = C + DC,
            spiral(Rows, Cols, NewR, NewC, Directions, NewDirIndex, NewStep, 0, NewAcc);
        true ->
            {DR, DC} = lists:nth(DirIndex + 1, Directions),
            NewR = R + DR,
            NewC = C + DC,
            spiral(Rows, Cols, NewR, NewC, Directions, DirIndex, Step, Count + 1, NewAcc)
    end.