-module(contains_duplicate_iii).
-export([contains_nearby_almost_duplicate/2]).

contains_nearby_almost_duplicate(_Nums, _K) ->
    erlang:error(not_implemented).

contains_nearby_almost_duplicate(Nums, K) ->
    contains_nearby_almost_duplicate(Nums, K, 0, #{}).

contains_nearby_almost_duplicate([], _K, _Index, _Map) ->
    false;

contains_nearby_almost_duplicate([N | Rest], K, Index, Map) ->
    BucketSize = K + 1,
    BucketId = N div BucketSize,
    case maps:is_key(BucketId, Map) of
        true ->
            true;
        false ->
            case maps:is_key(BucketId - 1, Map) of
                true ->
                    if abs(N - maps:get(BucketId - 1, Map)) < K -> true; true -> false end;
                false ->
                    case maps:is_key(BucketId + 1, Map) of
                        true ->
                            if abs(N - maps:get(BucketId + 1, Map)) < K -> true; true -> false end;
                        false ->
                            NewMap = maps:put(BucketId, N, Map),
                            contains_nearby_almost_duplicate(Rest, K, Index + 1, NewMap)
                    end
            end
    end.