-spec count_pairs(Nums :: [integer()], K :: integer()) -> integer().
count_pairs(Nums, K) ->
    Freq = maps:new(),
    lists:foldl(fun(Num, {Count, FreqMap}) ->
        Gcd = gcd(Num, K),
        lists:foldl(fun({G, C}, {Acc, FMap}) ->
            case (G * Gcd) rem K of
                0 -> {Acc + C, FMap};
                _ -> {Acc, FMap}
            end
        end, {Count, FreqMap}, maps:to_list(FreqMap)),
        NewFreqMap = maps:update_with(Gcd, fun(V) -> V + 1 end, 1, FreqMap),
        {Count, NewFreqMap}
    end, {0, Freq}, Nums),
    element(1, lists:last(lists:foldl(fun(Num, {Count, FreqMap}) ->
        Gcd = gcd(Num, K),
        lists:foldl(fun({G, C}, {Acc, FMap}) ->
            case (G * Gcd) rem K of
                0 -> {Acc + C, FMap};
                _ -> {Acc, FMap}
            end
        end, {Count, FreqMap}, maps:to_list(FreqMap)),
        NewFreqMap = maps:update_with(Gcd, fun(V) -> V + 1 end, 1, FreqMap),
        {Count, NewFreqMap}
    end, {0, maps:new()}, Nums))).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).