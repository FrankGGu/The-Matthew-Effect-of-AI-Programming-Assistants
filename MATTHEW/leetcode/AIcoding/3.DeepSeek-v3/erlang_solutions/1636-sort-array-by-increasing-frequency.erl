-spec frequency_sort(Nums :: [integer()]) -> [integer()].
frequency_sort(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> 
        maps:update_with(N, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, Nums),
    Sorted = lists:sort(fun(A, B) ->
        FreqA = maps:get(A, FreqMap),
        FreqB = maps:get(B, FreqMap),
        if
            FreqA =:= FreqB -> A >= B;
            true -> FreqA =< FreqB
        end
    end, Nums),
    Sorted.