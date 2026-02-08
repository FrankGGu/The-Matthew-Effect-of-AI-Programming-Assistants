-spec count_elements(Nums :: [integer()]) -> integer().
count_elements(Nums) ->
    case Nums of
        [] -> 0;
        [_] -> 0;
        _ ->
            Min = lists:min(Nums),
            Max = lists:max(Nums),
            lists:foldl(fun(X, Acc) -> 
                            if 
                                X > Min andalso X < Max -> Acc + 1;
                                true -> Acc
                            end
                        end, 0, Nums)
    end.