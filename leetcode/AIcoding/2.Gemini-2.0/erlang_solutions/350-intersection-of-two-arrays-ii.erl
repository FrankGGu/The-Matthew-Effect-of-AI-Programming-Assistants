-module(intersection_of_two_arrays_ii).
-export([intersect/2]).

intersect(Nums1, Nums2) ->
    Map1 = lists:foldl(fun(X, Acc) ->
        case maps:is_key(X, Acc) of
            true -> maps:update(X, maps:get(X, Acc) + 1, Acc);
            false -> maps:put(X, 1, Acc)
        end
    end, #{}, Nums1),

    lists:foldl(fun(X, {Result, Map}) ->
        case maps:is_key(X, Map) of
            true ->
                Count = maps:get(X, Map),
                if Count > 0 ->
                    {Result ++ [X], maps:update(X, Count - 1, Map)};
                true ->
                  {Result, Map}
                end;
            false -> {Result, Map}
        end
    end, {[], Map1}, Nums2) ||> fun({Result, _}) -> Result end.