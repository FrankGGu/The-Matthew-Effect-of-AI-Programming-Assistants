-spec min_speed_on_time(Dist :: [integer()], Hour :: float()) -> integer().
min_speed_on_time(Dist, Hour) ->
    case length(Dist) - 1 > Hour of
        true -> -1;
        false ->
            Min = 1,
            Max = lists:max(Dist) * 100,
            binary_search(Dist, Hour, Min, Max)
    end.

binary_search(Dist, Hour, Min, Max) when Min < Max ->
    Mid = (Min + Max) div 2,
    case can_arrive(Dist, Hour, Mid) of
        true -> binary_search(Dist, Hour, Min, Mid);
        false -> binary_search(Dist, Hour, Mid + 1, Max)
    end;
binary_search(_, _, Min, _) -> Min.

can_arrive(Dist, Hour, Speed) ->
    Time = lists:foldl(fun(D, Acc) -> Acc + ceil(D / Speed) end, 0.0, lists:sublist(Dist, length(Dist) - 1)),
    Time + (lists:last(Dist) / Speed) =< Hour.

ceil(X) ->
    T = trunc(X),
    case X - T > 0 of
        true -> T + 1;
        false -> T
    end.