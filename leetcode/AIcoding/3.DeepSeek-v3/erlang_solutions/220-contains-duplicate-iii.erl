-spec contains_nearby_almost_duplicate(Nums :: [integer()], IndexDiff :: integer(), ValueDiff :: integer()) -> boolean().
contains_nearby_almost_duplicate(Nums, IndexDiff, ValueDiff) ->
    contains_nearby_almost_duplicate(Nums, IndexDiff, ValueDiff, 0, #{}).

contains_nearby_almost_duplicate([], _, _, _, _) -> false;
contains_nearby_almost_duplicate([Num | Rest], K, T, I, Map) ->
    Bucket = get_bucket(Num, T + 1),
    case maps:is_key(Bucket, Map) of
        true -> true;
        false ->
            case maps:get(Bucket - 1, Map, none) of
                Val when Val =/= none, abs(Val - Num) =< T -> true;
                _ ->
                    case maps:get(Bucket + 1, Map, none) of
                        Val when Val =/= none, abs(Val - Num) =< T -> true;
                        _ ->
                            NewMap = maps:put(Bucket, Num, Map),
                            if
                                I >= K ->
                                    RemoveBucket = get_bucket(lists:nth(I - K + 1, Nums), T + 1),
                                    contains_nearby_almost_duplicate(Rest, K, T, I + 1, maps:remove(RemoveBucket, NewMap));
                                true ->
                                    contains_nearby_almost_duplicate(Rest, K, T, I + 1, NewMap)
                            end
                    end
            end
    end.

get_bucket(Num, W) when Num < 0 -> (Num + 1) div W - 1;
get_bucket(Num, W) -> Num div W.