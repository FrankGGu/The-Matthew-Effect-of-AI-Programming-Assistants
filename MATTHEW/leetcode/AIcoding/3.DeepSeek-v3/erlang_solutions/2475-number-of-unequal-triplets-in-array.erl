-spec unequal_triplets(Arr :: [integer()]) -> integer().
unequal_triplets(Arr) ->
    N = length(Arr),
    Count = 0,
    do_unequal_triplets(Arr, N, Count).

do_unequal_triplets(Arr, N, Count) ->
    case N < 3 of
        true -> Count;
        false ->
            [H | T] = Arr,
            NewCount = Count + count_pairs(T, H, 0),
            do_unequal_triplets(T, N - 1, NewCount)
    end.

count_pairs([], _, Acc) -> Acc;
count_pairs([X | Rest], First, Acc) ->
    case X =/= First of
        true -> count_pairs(Rest, First, Acc + count_uniques(Rest, X));
        false -> count_pairs(Rest, First, Acc)
    end.

count_uniques([], _) -> 0;
count_uniques([Y | Rest], Second) ->
    case Y =/= Second of
        true -> 1 + count_uniques(Rest, Second);
        false -> count_uniques(Rest, Second)
    end.