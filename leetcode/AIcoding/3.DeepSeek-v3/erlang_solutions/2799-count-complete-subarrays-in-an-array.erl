-spec count_complete_subarrays(Nums :: [integer()]) -> integer().
count_complete_subarrays(Nums) ->
    Distinct = sets:size(sets:from_list(Nums)),
    N = length(Nums),
    Count = 0,
    count_subarrays(Nums, Distinct, N, Count).

count_subarrays([], _, _, Count) -> Count;
count_subarrays([H | T], Distinct, N, Count) ->
    NewCount = check_subarrays([H | T], Distinct, 0, sets:new(), Count),
    count_subarrays(T, Distinct, N, NewCount).

check_subarrays(_, Distinct, CurrDistinct, _, Count) when CurrDistinct == Distinct -> Count + 1;
check_subarrays([], _, _, _, Count) -> Count;
check_subarrays([H | T], Distinct, CurrDistinct, Set, Count) ->
    case sets:is_element(H, Set) of
        true ->
            check_subarrays(T, Distinct, CurrDistinct, Set, Count);
        false ->
            NewSet = sets:add_element(H, Set),
            check_subarrays(T, Distinct, CurrDistinct + 1, NewSet, Count)
    end.