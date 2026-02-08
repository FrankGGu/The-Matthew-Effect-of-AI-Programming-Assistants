-module(four_sum_ii).
-export([four_sum_count/1]).

four_sum_count([A, B, C, D]) ->
    MapAB = lists:foldl(fun(X, Acc) ->
                              lists:foldl(fun(Y, Acc2) ->
                                                Sum = X + Y,
                                                case maps:is_key(Sum, Acc2) of
                                                    true ->
                                                        maps:update(Sum, maps:get(Sum, Acc2) + 1, Acc2);
                                                    false ->
                                                        maps:put(Sum, 1, Acc2)
                                                end
                                        end, Acc, B)
                      end, #{}, A),
    lists:foldl(fun(X, Acc) ->
                              lists:foldl(fun(Y, Acc2) ->
                                                Sum = X + Y,
                                                Target = -Sum,
                                                case maps:is_key(Target, MapAB) of
                                                    true ->
                                                        Acc2 + maps:get(Target, MapAB);
                                                    false ->
                                                        Acc2
                                                end
                                        end, Acc, D)
                      end, 0, C).