-module(solution).
-export([numIdenticalPairs/1]).

numIdenticalPairs(Nums) ->
    FreqMap = lists:foldl(fun(Num, AccMap) ->
                                  maps:update_with(Num, fun(Count) -> Count + 1 end, 1, AccMap)
                          end, maps:new(), Nums),
    maps:fold(fun(_Num, Count, Acc) ->
                      Acc + (Count * (Count - 1) div 2)
              end, 0, FreqMap).