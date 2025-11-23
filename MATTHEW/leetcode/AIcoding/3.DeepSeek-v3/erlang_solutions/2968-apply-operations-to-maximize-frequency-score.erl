-module(solution).
-export([max_frequency_score/1]).

max_frequency_score(Nums) ->
    Sorted = lists:sort(Nums),
    {Max, _} = lists:foldl(fun(N, {MaxFreq, FreqMap}) ->
        NewFreq = maps:get(N, FreqMap, 0) + 1,
        NewFreqMap = maps:put(N, NewFreq, FreqMap),
        {max(MaxFreq, NewFreq), NewFreqMap}
    end, {0, #{}}, Sorted),
    Max.