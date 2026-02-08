-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, Nums),
    min_operations(Sorted, 0, 0).

min_operations([], _Prev, Count) ->
    Count;
min_operations([H | T], Prev, Count) ->
    case T of
        [] -> Count;
        _ ->
            [Next | _] = T,
            if
                H == Next -> min_operations(T, Prev, Count);
                true -> min_operations(T, Prev + 1, Count + Prev + 1)
            end
    end.