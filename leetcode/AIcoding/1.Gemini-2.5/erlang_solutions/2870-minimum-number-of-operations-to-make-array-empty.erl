-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(Count) -> Count + 1 end, 1, Acc) end, maps:new(), Nums),

    Counts = maps:values(FreqMap),

    case lists:member(1, Counts) of
        true ->
            -1;
        false ->
            lists:foldl(fun(Count, Acc) ->
                            Acc + (Count + 2) div 3
                        end, 0, Counts)
    end.