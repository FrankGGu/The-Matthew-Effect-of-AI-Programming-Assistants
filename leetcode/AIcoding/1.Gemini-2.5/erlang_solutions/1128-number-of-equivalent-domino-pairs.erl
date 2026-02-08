-spec num_equivalent_domino_pairs(Dominoes :: [[integer()]]) -> integer().
num_equivalent_domino_pairs(Dominoes) ->
    FreqMap = lists:foldl(
        fun([A, B], AccMap) ->
            CanonicalDomino = [min(A, B), max(A, B)],
            CurrentCount = maps:get(CanonicalDomino, AccMap, 0),
            maps:put(CanonicalDomino, CurrentCount + 1, AccMap)
        end,
        #{},
        Dominoes
    ),

    TotalPairs = maps:foldl(
        fun(_CanonicalDomino, Count, AccPairs) ->
            AccPairs + (Count * (Count - 1) div 2)
        end,
        0,
        FreqMap
    ),
    TotalPairs.