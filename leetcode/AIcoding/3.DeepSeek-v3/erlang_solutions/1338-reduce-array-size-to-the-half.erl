-spec min_set_size(Arr :: [integer()]) -> integer().
min_set_size(Arr) ->
    FreqMap = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),
    FreqList = lists:reverse(lists:sort(maps:values(FreqMap))),
    min_set_size(FreqList, length(Arr), 0, 0).

min_set_size([], _, Count, _) -> Count;
min_set_size([H|T], Total, Count, Sum) ->
    NewSum = Sum + H,
    if 
        NewSum >= Total div 2 -> Count + 1;
        true -> min_set_size(T, Total, Count + 1, NewSum)
    end.