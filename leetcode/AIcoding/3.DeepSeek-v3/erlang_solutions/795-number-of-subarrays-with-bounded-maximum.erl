-spec num_subarrays_with_bounded_max(Nums :: [integer()], Left :: integer(), Right :: integer()) -> integer().
num_subarrays_with_bounded_max(Nums, Left, Right) ->
    count(Nums, Right + 1) - count(Nums, Left).

count(Nums, bound) ->
    lists:foldl(fun(N, {Res, Prev}) ->
        if
            N >= bound -> {Res, 0};
            true -> {Res + Prev + 1, Prev + 1}
        end
    end, {0, 0}, Nums),
    element(1, lists:foldl(fun(N, {Res, Prev}) ->
        if
            N >= bound -> {Res, 0};
            true -> {Res + Prev + 1, Prev + 1}
        end
    end, {0, 0}, Nums)).