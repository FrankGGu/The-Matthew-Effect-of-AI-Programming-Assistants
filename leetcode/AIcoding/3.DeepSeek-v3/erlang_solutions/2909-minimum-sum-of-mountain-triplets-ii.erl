-spec minimum_sum(Nums :: [integer()]) -> integer().
minimum_sum(Nums) ->
    N = length(Nums),
    Left = lists:foldl(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            _ -> [min(X, hd(Acc)) | Acc]
        end
    end, [], Nums),
    LeftMin = lists:reverse(Left),

    Right = lists:foldr(fun(X, Acc) -> 
        case Acc of
            [] -> [X];
            _ -> [min(X, hd(Acc)) | Acc]
        end
    end, [], Nums),
    RightMin = Right,

    lists:foldl(fun(I, MinSum) ->
        LeftVal = lists:nth(I, LeftMin),
        RightVal = lists:nth(I, RightMin),
        if
            LeftVal < lists:nth(I, Nums) andalso RightVal < lists:nth(I, Nums) ->
                NewSum = LeftVal + lists:nth(I, Nums) + RightVal,
                min(MinSum, NewSum);
            true ->
                MinSum
        end
    end, 16#3fffffff, lists:seq(2, N - 1)).