-module(solution).
-export([num_bad_pairs/1]).

num_bad_pairs(Numbers) ->
    CountMap = maps:from_list([{N, 0} || N <- Numbers]),
    lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, Acc) end, CountMap, Numbers),
    Total = length(Numbers),
    GoodPairs = 0,
    lists:foldl(fun({N, C}, Acc) ->
        GoodPairs = Acc + (C * (C - 1)) div 2,
        GoodPairs
    end, GoodPairs, maps:to_list(CountMap)),
    Total * (Total - 1) div 2 - GoodPairs.