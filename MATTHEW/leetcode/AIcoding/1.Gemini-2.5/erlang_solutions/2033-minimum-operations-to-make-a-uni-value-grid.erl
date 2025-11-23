-spec min_operations(Grid :: [[integer()]], X :: integer()) -> integer().
min_operations(Grid, X) ->
    FlatList = lists:append(Grid),
    N = length(FlatList),

    case N of
        0 -> 0; % Should not happen based on constraints (1 <= m, n)
        _ ->
            FirstRem = hd(FlatList) rem X,
            case lists:all(fun(E) -> E rem X == FirstRem end, FlatList) of
                true ->
                    SortedList = lists:sort(FlatList),
                    Median = lists:nth(N div 2 + 1, SortedList),

                    lists:foldl(fun(E, Acc) ->
                                    Acc + abs(E - Median) div X
                                end, 0, SortedList)
                false ->
                    -1
            end
    end.