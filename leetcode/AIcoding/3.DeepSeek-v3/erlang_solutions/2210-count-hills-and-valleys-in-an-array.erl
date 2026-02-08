-spec count_hill_valley(Nums :: [integer()]) -> integer().
count_hill_valley(Nums) ->
    Filtered = lists:filter(fun(X) -> X =/= undefined end, 
        lists:map(fun({X, Prev, Next}) -> 
            if 
                (Prev < X andalso X > Next) orelse (Prev > X andalso X < Next) -> 1;
                true -> undefined
            end
        end, 
        lists:filtermap(fun({X, I}) -> 
            case lists:nth(I, Nums) of
                Y when Y =/= X -> {true, {X, lists:nth(I - 1, Nums), lists:nth(I, Nums)}};
                _ -> false
            end
        end, 
        lists:zip(Nums, lists:seq(2, length(Nums))))))),
    length(Filtered).