-spec array_rank_transform(Arr :: [integer()]) -> [integer()].
array_rank_transform(Arr) ->
    Sorted = lists:sort(fun(A, B) -> A =< B end, Arr),
    RankMap = create_rank_map(Sorted, #{}, 1),
    [maps:get(X, RankMap) || X <- Arr].

create_rank_map([], Map, _) -> Map;
create_rank_map([H | T], Map, Rank) ->
    case maps:is_key(H, Map) of
        true -> create_rank_map(T, Map, Rank);
        false -> create_rank_map(T, Map#{H => Rank}, Rank + 1)
    end.