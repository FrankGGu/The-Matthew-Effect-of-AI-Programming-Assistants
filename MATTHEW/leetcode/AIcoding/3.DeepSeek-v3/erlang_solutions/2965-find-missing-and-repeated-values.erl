-spec find_missing_and_repeated_values(Grid :: [[integer()]]) -> [integer()].
find_missing_and_repeated_values(Grid) ->
    N = length(Grid),
    Total = lists:seq(1, N * N),
    Flat = lists:flatten(Grid),
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Flat),
    Repeated = [X || X <- Total, maps:get(X, Counts, 0) == 2],
    Missing = [X || X <- Total, not maps:is_key(X, Counts)],
    [hd(Repeated), hd(Missing)].