-spec count_paths(Nums :: [integer()], K :: integer()) -> integer().
count_paths(Nums, K) ->
    count_paths(Nums, K, 0, #{}).

count_paths([], _, _, _) -> 0;
count_paths([Num | Rest], K, CurrentXor, Map) ->
    NewXor = CurrentXor bxor Num,
    Count = maps:get(NewXor bxor K, Map, 0),
    NewMap = maps:update_with(NewXor, fun(V) -> V + 1 end, 1, Map),
    if
        NewXor =:= K -> Count + 1 + count_paths(Rest, K, NewXor, NewMap);
        true -> Count + count_paths(Rest, K, NewXor, NewMap)
    end.