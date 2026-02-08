-spec contains_nearby_duplicate(Nums :: [integer()], K :: integer()) -> boolean().
contains_nearby_duplicate(Nums, K) ->
    contains_nearby_duplicate(Nums, K, 0, #{}).

contains_nearby_duplicate([], _K, _Index, _Map) -> false;
contains_nearby_duplicate([Num | Rest], K, Index, Map) ->
    case maps:find(Num, Map) of
        {ok, PrevIndex} when Index - PrevIndex =< K ->
            true;
        _ ->
            contains_nearby_duplicate(Rest, K, Index + 1, maps:put(Num, Index, Map))
    end.