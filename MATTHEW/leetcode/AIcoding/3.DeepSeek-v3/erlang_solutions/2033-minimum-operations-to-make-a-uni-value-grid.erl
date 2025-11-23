-spec min_operations(Grid :: [[integer()]], X :: integer()) -> integer().
min_operations(Grid, X) ->
    Flattened = lists:flatten(Grid),
    Sorted = lists:sort(Flattened),
    Median = lists:nth(length(Sorted) div 2 + 1, Sorted),
    lists:foldl(fun(N, Acc) ->
        Diff = abs(N - Median),
        case Diff rem X of
            0 -> Acc + Diff div X;
            _ -> -1
        end
    end, 0, Sorted).