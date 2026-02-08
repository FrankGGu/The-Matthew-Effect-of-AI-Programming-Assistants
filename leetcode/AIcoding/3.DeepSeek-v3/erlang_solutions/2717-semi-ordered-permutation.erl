-spec semi_ordered_permutation(Nums :: [integer()]) -> integer().
semi_ordered_permutation(Nums) ->
    N = length(Nums),
    Pos1 = index_of(1, Nums),
    PosN = index_of(N, Nums),
    if
        Pos1 < PosN -> Pos1 + (N - 1 - PosN);
        true -> Pos1 + (N - 1 - PosN) - 1
    end.

index_of(Value, List) -> index_of(Value, List, 0).

index_of(Value, [Value | _], Index) -> Index;
index_of(Value, [_ | Rest], Index) -> index_of(Value, Rest, Index + 1).