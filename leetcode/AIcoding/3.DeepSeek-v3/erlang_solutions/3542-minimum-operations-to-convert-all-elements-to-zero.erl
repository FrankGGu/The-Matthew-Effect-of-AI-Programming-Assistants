-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    min_operations(Nums, 0).

min_operations([], Count) ->
    Count;
min_operations(Nums, Count) ->
    case lists:all(fun(X) -> X =:= 0 end, Nums) of
        true -> Count;
        false ->
            Min = lists:min([X || X <- Nums, X =/= 0]),
            NewNums = lists:map(fun(X) ->
                if X =/= 0 -> X - Min;
                   true -> 0
                end
            end, Nums),
            min_operations(NewNums, Count + 1)
    end.