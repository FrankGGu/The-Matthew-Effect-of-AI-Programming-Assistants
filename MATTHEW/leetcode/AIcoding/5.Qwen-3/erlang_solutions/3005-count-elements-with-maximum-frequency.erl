-module(count_elements_with_max_frequency).
-export([max_freq/1]).

max_freq(Nums) ->
    Count = lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, maps:new(), Nums),
    MaxFreq = lists:max(maps:values(Count)),
    lists:sum([1 || {_K, V} <- maps:to_list(Count), V == MaxFreq]).