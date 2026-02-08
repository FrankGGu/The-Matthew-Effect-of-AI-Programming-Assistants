-module(solution).
-export([find_shortest_subarray/1]).

find_shortest_subarray(Nums) ->
    StatsMap = build_stats(Nums, 0, #{}),
    Degree = calculate_degree(StatsMap),
    find_min_length(StatsMap, Degree).

build_stats([], _Index, AccMap) ->
    AccMap;
build_stats([H|T], Index, AccMap) ->
    case maps:find(H, AccMap) of
        {ok, #{count := Count, first := First, last := _OldLast}} ->
            NewStats = #{count => Count + 1, first => First, last => Index},
            NewAccMap = maps:put(H, NewStats, AccMap),
            build_stats(T, Index + 1, NewAccMap);
        error ->
            NewStats = #{count => 1, first => Index, last => Index},
            NewAccMap = maps:put(H, NewStats, AccMap),
            build_stats(T, Index + 1, NewAccMap)
    end.

calculate_degree(StatsMap) ->
    lists:foldl(fun(#{count := Count}, MaxDegree) ->
                    max(Count, MaxDegree)
                end, 0, maps:values(StatsMap)).

find_min_length(StatsMap, Degree) ->
    lists:foldl(fun(#{count := Count, first := First, last := Last}, MinLen) ->
                    if
                        Count == Degree ->
                            Len = Last - First + 1,
                            min(Len, MinLen);
                        true ->
                            MinLen
                    end
                end, infinity, maps:values(StatsMap)).