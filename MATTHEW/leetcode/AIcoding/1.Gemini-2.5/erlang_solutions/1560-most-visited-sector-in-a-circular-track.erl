-module(solution).
-export([mostVisited/2]).

mostVisited(N, Rounds) ->
    increment_range(CurrentS, TargetS, MaxN, AccMap) ->
        if CurrentS =< TargetS ->
            lists:foldl(fun(S, Map) -> maps:update_with(S, fun(V) -> V + 1 end, 1, Map) end, AccMap, lists:seq(CurrentS, TargetS));
           CurrentS > TargetS ->
            Map1 = lists:foldl(fun(S, Map) -> maps:update_with(S, fun(V) -> V + 1 end, 1, Map) end, AccMap, lists:seq(CurrentS, MaxN)),
            lists:foldl(fun(S, Map) -> maps:update_with(S, fun(V) -> V + 1 end, 1, Map) end, Map1, lists:seq(1, TargetS))
        end.

    SectorCounts = maps:new(),

    ActualFinalCounts =
        case length(Rounds) of
            1 -> maps:put(hd(Rounds), 1, SectorCounts);
            _ ->
                lists:foldl(
                    fun({Start, End}, AccCounts) ->
                        increment_range(Start, End, N, AccCounts)
                    end,
                    SectorCounts,
                    lists:zip(lists:droplast(Rounds), lists:tl(Rounds))
                )
        end,

    MaxCount = maps:fold(fun(_K, V, AccMax) -> max(V, AccMax) end, 0, ActualFinalCounts),

    Result = maps:fold(
        fun(S, C, AccList) ->
            if C == MaxCount -> [S | AccList];
               true -> AccList
            end
        end,
        [],
        ActualFinalCounts
    ),

    lists:sort(Result).