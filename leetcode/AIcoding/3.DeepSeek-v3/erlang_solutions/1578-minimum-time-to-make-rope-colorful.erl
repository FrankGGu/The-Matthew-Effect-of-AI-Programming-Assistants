-spec min_cost(Colors :: unicode:unicode_binary(), NeededTime :: [integer()]) -> integer().
min_cost(Colors, NeededTime) ->
    min_cost(Colors, NeededTime, 0, 0, 0, 0).

min_cost(<<>>, [], TotalCost, _PrevColor, _PrevMax, _CurrentSum) ->
    TotalCost;
min_cost(<<Color:8, RestColors/binary>>, [Time | RestTimes], TotalCost, PrevColor, PrevMax, CurrentSum) ->
    if
        Color =:= PrevColor ->
            NewSum = CurrentSum + Time,
            NewMax = max(PrevMax, Time),
            min_cost(RestColors, RestTimes, TotalCost, Color, NewMax, NewSum);
        true ->
            NewTotalCost = TotalCost + CurrentSum - PrevMax,
            min_cost(RestColors, RestTimes, NewTotalCost, Color, Time, Time)
    end.