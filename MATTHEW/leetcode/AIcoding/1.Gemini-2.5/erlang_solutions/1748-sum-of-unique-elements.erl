-module(solution).
-export([sum_unique_elements/1]).

sum_unique_elements(Nums) ->
    FreqMap = lists:foldl(fun(X, AccMap) ->
                                  maps:update_with(X, fun(V) -> V + 1 end, 1, AccMap)
                          end, maps:new(), Nums),
    lists:foldl(fun({Key, Value}, AccSum) ->
                        if Value == 1 -> AccSum + Key;
                           true -> AccSum
                        end
                end, 0, maps:to_list(FreqMap)).