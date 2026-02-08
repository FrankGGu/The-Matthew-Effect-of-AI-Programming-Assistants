-module(solution).
-export([num_good_ways/1]).

num_good_ways(S) ->
    Count = length(S),
    PrefixCounts = lists:foldl(fun(Char, {Count, Prefix}) ->
        NewPrefix = maps:get(Char, Prefix, 0) + 1,
        {Count, maps:put(Char, NewPrefix, Prefix)}
    end, {0, #{}}, S),
    maps:fold(fun(_, V, Acc) -> Acc + V end, 0, maps:map(fun(_, V) -> V * (Count - V) end, PrefixCounts)).