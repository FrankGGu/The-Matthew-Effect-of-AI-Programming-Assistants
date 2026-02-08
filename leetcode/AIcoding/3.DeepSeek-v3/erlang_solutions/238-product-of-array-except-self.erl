-spec product_except_self(Nums :: [integer()]) -> [integer()].
product_except_self(Nums) ->
    Length = length(Nums),
    LeftProducts = lists:foldl(fun(Num, Acc) -> 
        case Acc of
            [] -> [Num];
            _ -> [Num * hd(Acc) | Acc]
        end
    end, [], Nums),
    RightProducts = lists:foldr(fun(Num, Acc) -> 
        case Acc of
            [] -> [Num];
            _ -> [Num * hd(Acc) | Acc]
        end
    end, [], Nums),
    Result = lists:foldl(fun(I, Acc) ->
        Left = if I == 1 -> 1; true -> lists:nth(I - 1, LeftProducts) end,
        Right = if I == Length -> 1; true -> lists:nth(Length - I, RightProducts) end,
        [Left * Right | Acc]
    end, [], lists:seq(1, Length)),
    lists:reverse(Result).