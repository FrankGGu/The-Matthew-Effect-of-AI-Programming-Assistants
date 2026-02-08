-spec max_chunks_to_sorted(Arr :: [integer()]) -> integer().
max_chunks_to_sorted(Arr) ->
    Sorted = lists:sort(Arr),
    Max = 0,
    Count = 0,
    {_, Res} = lists:foldl(fun(X, {I, {CurrentMax, C}}) ->
        NewMax = max(X, CurrentMax),
        if 
            NewMax == lists:nth(I + 1, Sorted) -> {I + 1, {NewMax, C + 1}};
            true -> {I + 1, {NewMax, C}}
        end
    end, {0, {-1, 0}}, Arr),
    Res.