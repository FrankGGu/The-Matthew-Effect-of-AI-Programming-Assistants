-module(solution).
-export([max_performance/4]).

sort_engineers(Engineers) ->
    lists:sort(fun({_S1, E1}, {_S2, E2}) -> E1 >= E2 end, Engineers).

max_performance(_N, Speeds, Efficiencies, K) ->
    Engineers = lists:zip(Speeds, Efficiencies),
    SortedEngineers = sort_engineers(Engineers),

    InitialState = {0, 0, gb_trees:empty(), 0},

    {MaxPerformance, _, _, _} = lists:foldl(
        fun({S, E}, {AccMaxPerf, AccSum, MinHeap, UniqueIDCounter}) ->
            NewUniqueIDCounter = UniqueIDCounter + 1,
            CurrentSpeedKey = {S, NewUniqueIDCounter},

            NewMinHeap = gb_trees:insert(CurrentSpeedKey, true, MinHeap),
            NewSum = AccSum + S,

            {UpdatedMinHeap, UpdatedSum} =
                case gb_trees:size(NewMinHeap) > K of
                    true ->
                        {{SmallestS, SmallestID}, _} = gb_trees:smallest(NewMinHeap),
                        RemovedMinHeap = gb_trees:delete({SmallestS, SmallestID}, NewMinHeap),
                        {RemovedMinHeap, NewSum - SmallestS};
                    false ->
                        {NewMinHeap, NewSum}
                end,

            CurrentPerformance = UpdatedSum * E,
            NewMaxPerf = max(AccMaxPerf, CurrentPerformance),

            {NewMaxPerf, UpdatedSum, UpdatedMinHeap, NewUniqueIDCounter}
        end,
        InitialState,
        SortedEngineers
    ),
    MaxPerformance.