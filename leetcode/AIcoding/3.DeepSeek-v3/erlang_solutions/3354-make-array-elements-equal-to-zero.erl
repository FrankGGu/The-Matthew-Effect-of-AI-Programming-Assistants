-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    min_operations(Nums, 0).

min_operations([], Count) -> Count;
min_operations(Nums, Count) ->
    case lists:min(Nums) of
        0 ->
            Filtered = lists:filter(fun(X) -> X =/= 0 end, Nums),
            min_operations(Filtered, Count);
        Min ->
            Subtracted = lists:map(fun(X) -> X - Min end, Nums),
            min_operations(Subtracted, Count + 1)
    end.