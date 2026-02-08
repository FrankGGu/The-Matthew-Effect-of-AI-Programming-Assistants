-spec min_subsequence(Nums :: [integer()]) -> [integer()].
min_subsequence(Nums) ->
    Sorted = lists:reverse(lists:sort(Nums)),
    TotalSum = lists:sum(Nums),
    min_subsequence(Sorted, TotalSum, 0, []).

min_subsequence([], _TotalSum, _CurrentSum, Acc) ->
    lists:reverse(Acc);
min_subsequence([H | T], TotalSum, CurrentSum, Acc) ->
    NewSum = CurrentSum + H,
    if 
        NewSum > TotalSum - NewSum ->
            lists:reverse([H | Acc]);
        true ->
            min_subsequence(T, TotalSum, NewSum, [H | Acc])
    end.