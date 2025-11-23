-spec contains_nearby_almost_duplicate(Nums :: [integer()], K :: integer(), T :: integer()) -> boolean().
contains_nearby_almost_duplicate(Nums, K, T) ->
    Buckets = #{},
    process(Nums, K, T, Buckets, 0).

process([], _, _, _, _) ->
    false;
process([Num | Rest], K, T, Buckets, I) ->
    Bucket = get_bucket(Num, T),
    case maps:is_key(Bucket, Buckets) of
        true ->
            true;
        false ->
            case maps:is_key(Bucket - 1, Buckets) andalso abs(maps:get(Bucket - 1, Buckets) - Num) =< T of
                true ->
                    true;
                false ->
                    case maps:is_key(Bucket + 1, Buckets) andalso abs(maps:get(Bucket + 1, Buckets) - Num) =< T of
                        true ->
                            true;
                        false ->
                            NewBuckets = maps:put(Bucket, Num, Buckets),
                            if I >= K ->
                                    RemovedBucket = get_bucket(lists:nth(I - K + 1, Nums), T),
                                    process(Rest, K, T, maps:remove(RemovedBucket, NewBuckets), I + 1);
                               true ->
                                    process(Rest, K, T, NewBuckets, I + 1)
                            end
                    end
            end
    end.

get_bucket(Num, T) when T == 0 ->
    Num;
get_bucket(Num, T) ->
    case Num >= 0 of
        true -> Num div (T + 1);
        false -> (Num + 1) div (T + 1) - 1
    end.