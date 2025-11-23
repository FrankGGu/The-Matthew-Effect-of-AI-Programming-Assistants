-module(solution).
-export([mergeSimilarItems/2]).

mergeSimilarItems(Items1, Items2) ->
    AggregatedMap = lists:foldl(
        fun([V, W], AccMap) ->
            maps:update_with(V, fun(ExistingW) -> ExistingW + W end, W, AccMap)
        end,
        lists:foldl(
            fun([V, W], AccMap) ->
                maps:update_with(V, fun(ExistingW) -> ExistingW + W end, W, AccMap)
            end,
            #{},
            Items1
        ),
        Items2
    ),
    ListOfPairs = lists:map(fun({V, W}) -> [V, W] end, maps:to_list(AggregatedMap)),
    lists:keysort(1, ListOfPairs).