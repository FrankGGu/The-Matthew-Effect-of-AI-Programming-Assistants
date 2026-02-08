-spec tuple_same_product(Products :: [integer()]) -> integer().
tuple_same_product(Products) ->
    CountMap = maps:new(),
    N = length(Products),
    CountMap1 = lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc1) ->
            if
                I < J ->
                    Product = lists:nth(I, Products) * lists:nth(J, Products),
                    maps:update_with(Product, fun(V) -> V + 1 end, 1, Acc1);
                true ->
                    Acc1
            end
        end, Acc, lists:seq(1, N))
    end, CountMap, lists:seq(1, N)),
    maps:fold(fun(_, V, Acc) ->
        if
            V >= 2 ->
                Acc + V * (V - 1) * 4;
            true ->
                Acc
        end
    end, 0, CountMap1).