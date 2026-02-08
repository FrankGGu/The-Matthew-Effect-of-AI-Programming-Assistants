-spec brick_wall(Wall :: [[integer()]]) -> integer().
brick_wall(Wall) ->
    TotalRows = length(Wall),
    case TotalRows of
        0 -> 0;
        _ ->
            GapCounts = lists:foldl(fun(Row, AccMap) ->
                                        calculate_gaps(Row, 0, AccMap)
                                    end, maps:new(), Wall),
            MaxGapCount = maps:fold(fun(_Pos, Count, Max) ->
                                        max(Count, Max)
                                    end, 0, GapCounts),
            TotalRows - MaxGapCount
    end.

calculate_gaps([], _CurrentSum, AccMap) ->
    AccMap;
calculate_gaps([_LastBrick], _CurrentSum, AccMap) ->
    AccMap;
calculate_gaps([H|T], CurrentSum, AccMap) ->
    NewSum = CurrentSum + H,
    UpdatedMap = maps:update_with(NewSum, fun(Val) -> Val + 1 end, 1, AccMap),
    calculate_gaps(T, NewSum, UpdatedMap).