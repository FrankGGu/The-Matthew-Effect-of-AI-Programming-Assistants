-module(contains_duplicate_iii).
-export([contains_nearby_almost_duplicate/2]).

contains_nearby_almost_duplicate(Nums, k) ->
    contains_nearby_almost_duplicate(Nums, k, 0, dict:new()).

contains_nearby_almost_duplicate([], _, _, _) ->
    false;
contains_nearby_almost_duplicate([N | Rest], K, I, Dict) ->
    BucketSize = K + 1,
    BucketId = bucket_id(N, BucketSize),
    case dict:is_key(BucketId, Dict) of
        true ->
            {Value, _} = dict:fetch(BucketId, Dict),
            if abs(N - Value) =< K -> true;
               true -> false
            end;
        false ->
            case check_neighbors(N, K, BucketId, Dict) of
                true -> true;
                false ->
                    dict:store(BucketId, N, Dict),
                    contains_nearby_almost_duplicate(Rest, K, I + 1, Dict)
            end
    end.

bucket_id(X, Size) ->
    if X >= 0 -> X div Size;
       true -> (X div Size) - 1
    end.

check_neighbors(_, _, _, _) ->
    false.