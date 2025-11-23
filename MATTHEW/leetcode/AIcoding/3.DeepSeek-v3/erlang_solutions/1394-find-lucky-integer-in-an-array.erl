-spec find_lucky(Arr :: [integer()]) -> integer().
find_lucky(Arr) ->
    Counts = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Arr),
    Luckies = maps:filter(fun(K, V) -> K =:= V end, Counts),
    case maps:size(Luckies) of
        0 -> -1;
        _ -> lists:max(maps:keys(Luckies))
    end.