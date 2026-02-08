-spec contains_nearby_duplicate(Nums :: [integer()], K :: integer()) -> boolean().
contains_nearby_duplicate(Nums, K) ->
    contains_nearby_duplicate(Nums, K, #{}).

contains_nearby_duplicate([], _, _) -> false;
contains_nearby_duplicate([H | T], K, Seen) ->
    case lists:keyfind(H, 1, Seen) of
        false -> contains_nearby_duplicate(T, K, [{H, 0} | Seen]);
        {H, Index} when (length(Seen) - Index) =< K -> true;
        _ -> contains_nearby_duplicate(T, K, Seen)
    end.
