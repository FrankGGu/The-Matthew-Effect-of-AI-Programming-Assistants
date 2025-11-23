-spec find_duplicate(Nums :: [integer()]) -> integer().
find_duplicate(Nums) ->
    find_duplicate(Nums, #{}).

find_duplicate([], _Map) -> -1;
find_duplicate([H|T], Map) ->
    case maps:is_key(H, Map) of
        true -> H;
        false -> find_duplicate(T, Map#{H => 1})
    end.