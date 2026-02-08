-spec average_value(Nums :: [integer()]) -> float().
average_value(Nums) ->
    Filtered = lists:filter(fun(X) -> (X rem 2 == 0) and (X rem 3 == 0) end, Nums),
    case Filtered of
        [] -> 0.0;
        _ -> 
            Sum = lists:sum(Filtered),
            Count = length(Filtered),
            Sum / Count
    end.