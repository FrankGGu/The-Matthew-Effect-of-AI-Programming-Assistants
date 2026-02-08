-spec boundary_count(Steps :: [integer()]) -> integer().
boundary_count(Steps) ->
    {Count, _} = lists:foldl(fun(Step, {Cnt, Pos}) ->
        NewPos = Pos + Step,
        NewCnt = if NewPos == 0 -> Cnt + 1; true -> Cnt end,
        {NewCnt, NewPos}
    end, {0, 0}, Steps),
    Count.