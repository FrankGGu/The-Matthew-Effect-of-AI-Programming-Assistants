-spec find_poisoned_duration(TimeSeries :: [integer()], Duration :: integer()) -> integer().
find_poisoned_duration(TimeSeries, Duration) ->
    case TimeSeries of
        [] -> 0;
        [H | T] -> 
            lists:foldl(fun(X, {Prev, Total}) -> 
                NewTotal = Total + min(X - Prev, Duration),
                {X, NewTotal}
            end, {H, Duration}, T)
    end.