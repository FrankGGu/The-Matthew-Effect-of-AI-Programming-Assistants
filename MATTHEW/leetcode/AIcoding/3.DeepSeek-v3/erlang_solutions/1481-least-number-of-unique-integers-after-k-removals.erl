-spec find_least_num_of_unique_ints(Arr :: [integer()], K :: integer()) -> integer().
find_least_num_of_unique_ints(Arr, K) ->
    FreqMap = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),
    FreqList = lists:sort(maps:values(FreqMap)),
    remove_elements(FreqList, K).

remove_elements([], _) -> 0;
remove_elements([H|T], K) when H =< K -> remove_elements(T, K - H);
remove_elements(FreqList, _) -> length(FreqList).