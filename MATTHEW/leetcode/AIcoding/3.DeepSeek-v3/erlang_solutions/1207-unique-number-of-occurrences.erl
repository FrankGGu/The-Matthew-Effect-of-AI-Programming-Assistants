-spec unique_occurrences(Arr :: [integer()]) -> boolean().
unique_occurrences(Arr) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),
    Values = maps:values(Counts),
    length(Values) == sets:size(sets:from_list(Values)).