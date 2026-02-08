-spec count_max_or_subsets(Nums :: [integer()]) -> integer().
count_max_or_subsets(Nums) ->
    MaxOr = lists:foldl(fun(N, Acc) -> Acc bor N end, 0, Nums),
    count_subsets(Nums, 0, 0, MaxOr).

count_subsets([], CurrentOr, Count, MaxOr) ->
    if CurrentOr == MaxOr -> Count + 1;
       true -> Count
    end;
count_subsets([H | T], CurrentOr, Count, MaxOr) ->
    NewOr = CurrentOr bor H,
    Count1 = count_subsets(T, NewOr, Count, MaxOr),
    count_subsets(T, CurrentOr, Count1, MaxOr).