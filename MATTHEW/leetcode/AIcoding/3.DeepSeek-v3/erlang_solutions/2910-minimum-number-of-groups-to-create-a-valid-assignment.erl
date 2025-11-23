-module(solution).
-export([min_groups/1]).

min_groups(Nums) ->
    FreqMap = lists:foldl(fun(N, Acc) -> 
                              maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) 
                          end, #{}, Nums),
    Frequencies = maps:values(FreqMap),
    MinFreq = lists:min(Frequencies),
    lists:sum([(Freq + MinFreq) div (MinFreq + 1) || Freq <- Frequencies]).