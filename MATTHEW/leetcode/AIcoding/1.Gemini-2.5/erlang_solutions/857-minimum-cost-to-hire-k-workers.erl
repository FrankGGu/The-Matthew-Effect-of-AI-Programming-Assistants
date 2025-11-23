-module(solution).
-export([min_cost_to_hire_k_workers/3]).

min_cost_to_hire_k_workers(Wages, Quality, K) ->
    Workers = lists:zip(Wages, Quality),

    WorkerData = lists:map(fun({W, Q}) -> {W / Q, Q} end, Workers),

    SortedWorkerData = lists:sort(fun({R1, _}, {R2, _}) -> R1 =< R2 end, WorkerData),

    InitialAcc = {float(1.0/0.0), 0.0, gb_trees:empty(), 0},

    {FinalMinCost, _, _, _} = lists:foldl(
        fun({Ratio, Quality}, {AccMinCost, AccQualitySum, AccMaxHeap, AccHeapSize}) ->
            NewQualitySum = AccQualitySum + Quality,

            NewMaxHeap = gb_trees:update_counter(Quality, 1, AccMaxHeap),
            NewHeapSize = AccHeapSize + 1,

            {UpdatedQualitySum, UpdatedMaxHeap, UpdatedHeapSize} = 
                if NewHeapSize > K ->
                    {LargestQuality, Count} = gb_trees:largest(NewMaxHeap),

                    ReducedQualitySum = NewQualitySum - LargestQuality,

                    HeapAfterRemoval = 
                        if Count == 1 ->
                            gb_trees:delete(LargestQuality, NewMaxHeap);
                        true ->
                            gb_trees:update_counter(LargestQuality, -1, NewMaxHeap)
                        end,

                    {ReducedQualitySum, HeapAfterRemoval, NewHeapSize - 1};
                true ->
                    {NewQualitySum, NewMaxHeap, NewHeapSize}
                end,

            NewMinCost = 
                if UpdatedHeapSize == K ->
                    CurrentCost = Ratio * UpdatedQualitySum,
                    min(AccMinCost, CurrentCost);
                true ->
                    AccMinCost
                end,

            {NewMinCost, UpdatedQualitySum, UpdatedMaxHeap, UpdatedHeapSize}
        end,
        InitialAcc,
        SortedWorkerData
    ),

    FinalMinCost.