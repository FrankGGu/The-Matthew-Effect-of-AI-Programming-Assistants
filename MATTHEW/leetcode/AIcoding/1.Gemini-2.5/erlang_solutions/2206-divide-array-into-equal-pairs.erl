-module(solution).
-export([divide_array/1]).

divide_array(Nums) ->
    FreqMap = lists:foldl(fun(X, AccMap) ->
                                  maps:update_with(X, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, maps:new(), Nums),

    lists:all(fun(Count) ->
                      Count rem 2 =:= 0
              end, maps:values(FreqMap)).