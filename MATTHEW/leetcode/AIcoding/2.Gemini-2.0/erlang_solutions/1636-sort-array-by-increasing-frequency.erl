-module(sort_by_frequency).
-export([frequency_sort/1]).

frequency_sort(Nums) ->
    Frequencies = lists:foldl(fun(X, Acc) ->
                                      maps:update_with(X, fun(V) -> V + 1 end, 1, Acc)
                                  end, #{}, Nums),
    Sorted = lists:keysort(2, [{K, maps:get(K, Frequencies)} || K <- maps:keys(Frequencies)]),
    lists:foldl(fun({Num, Freq}, Acc) ->
                        lists:append(lists:duplicate(Freq, [Num]), Acc)
                end, [], Sorted).