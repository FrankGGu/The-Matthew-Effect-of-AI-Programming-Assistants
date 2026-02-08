-spec min_array_length(Nums :: [integer()]) -> integer().
min_array_length(Nums) ->
    SortedNums = lists:sort(Nums),
    N = length(SortedNums),
    HalfN = N div 2,

    {L1, L2} = lists:split(HalfN, SortedNums),

    Count = count_pairs(L1, L2, 0),

    N - 2 * Count.

count_pairs([], _L2, Acc) -> Acc;
count_pairs(_L1, [], Acc) -> Acc;
count_pairs([H1 | T1], [H2 | T2], Acc) ->
    if
        H1 * 2 =< H2 ->
            count_pairs(T1, T2, Acc + 1);
        true ->
            count_pairs([H1 | T1], T2, Acc)
    end.