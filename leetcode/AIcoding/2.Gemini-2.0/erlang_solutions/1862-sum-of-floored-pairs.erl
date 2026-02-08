-module(floored_pairs).
-export([sum_of_floored_pairs/1]).

sum_of_floored_pairs(Nums) ->
    N = length(Nums),
    Counts = lists:foldl(fun(X, Acc) ->
                                MapKey = X,
                                case maps:is_key(MapKey, Acc) of
                                    true ->
                                        maps:update(MapKey, maps:get(MapKey, Acc) + 1, Acc);
                                    false ->
                                        maps:put(MapKey, 1, Acc)
                                end
                            end, #{}, Nums),

    lists:foldl(fun(X, Acc) ->
                        CountX = maps:get(X, Counts),
                        Acc + lists:foldl(fun(Y, InnerAcc) ->
                                                Floor = Y div X,
                                                CountY = maps:get(Y, Counts, 0),
                                                InnerAcc + Floor * CountX * CountY
                                            end, 0, maps:keys(Counts))
                end, 0, maps:keys(Counts)) rem 1000000007.