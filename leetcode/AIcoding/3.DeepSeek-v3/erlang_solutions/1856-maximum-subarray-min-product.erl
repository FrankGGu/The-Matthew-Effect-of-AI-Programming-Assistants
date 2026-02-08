-spec max_sum_min_product(Nums :: [integer()]) -> integer().
max_sum_min_product(Nums) ->
    N = length(Nums),
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) + X | Acc] end, [0], lists:reverse(Nums)),
    PrefixSum = lists:reverse(Prefix),

    Left = array:new(N, {default, 0}),
    Stack = [],
    {Left1, _} = lists:foldl(fun(I, {L, S}) ->
        Num = lists:nth(I + 1, Nums),
        NewS = case S of
            [] -> S;
            _ ->
                {TopI, _} = hd(S),
                TopNum = lists:nth(TopI + 1, Nums),
                if 
                    TopNum >= Num -> 
                        {_, NewS1} = lists:splitwith(fun({_, X}) -> X >= Num end, S),
                        NewS1;
                    true -> S
                end
        end,
        NewI = case NewS of
            [] -> 0;
            _ -> {TopI1, _} = hd(NewS),
                 TopI1 + 1
        end,
        NewL = array:set(I, NewI, L),
        NewS1 = [{I, Num} | NewS],
        {NewL, NewS1}
    end, {Left, Stack}, lists:seq(0, N - 1)),

    Right = array:new(N, {default, N - 1}),
    Stack1 = [],
    {Right1, _} = lists:foldr(fun(I, {R, S}) ->
        Num = lists:nth(I + 1, Nums),
        NewS = case S of
            [] -> S;
            _ ->
                {TopI, _} = hd(S),
                TopNum = lists:nth(TopI + 1, Nums),
                if 
                    TopNum >= Num -> 
                        {_, NewS1} = lists:splitwith(fun({_, X}) -> X >= Num end, S),
                        NewS1;
                    true -> S
                end
        end,
        NewI = case NewS of
            [] -> N - 1;
            _ -> {TopI1, _} = hd(NewS),
                 TopI1 - 1
        end,
        NewR = array:set(I, NewI, R),
        NewS1 = [{I, Num} | NewS],
        {NewR, NewS1}
    end, {Right, Stack1}, lists:seq(0, N - 1)),

    MaxProduct = lists:foldl(fun(I, Acc) ->
        L = array:get(I, Left1),
        R = array:get(I, Right1),
        Sum = lists:nth(R + 2, PrefixSum) - lists:nth(L + 1, PrefixSum),
        Product = lists:nth(I + 1, Nums) * Sum,
        max(Acc, Product)
    end, 0, lists:seq(0, N - 1)),

    MaxProduct rem 1000000007.