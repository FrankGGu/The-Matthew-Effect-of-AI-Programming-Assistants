-module(solution).
-export([max_subsequence_score/3]).

max_subsequence_score(Nums, Multipliers, K) ->
    Paired = lists:zip(Multipliers, Nums),
    SortedPaired = lists:sort(fun({M1, _}, {M2, _}) -> M1 >= M2 end, Paired),

    % State for foldl: {CurrentSum, MinHeap, HeapActualSize, MaxScore}
    % MinHeap: gb_trees where keys are numbers (N) and values are their counts.
    InitialState = {0, gb_trees:empty(), 0, 0},

    {_, _, _, FinalMaxScore} = lists:foldl(
        fun({M, N}, {CurrentSum, MinHeap, HeapActualSize, MaxScore}) ->
            % Add N to the heap and sum
            NewMinHeap1 = gb_trees:insert(N, gb_trees:get(N, MinHeap, 0) + 1, MinHeap),
            NewCurrentSum1 = CurrentSum + N,
            NewHeapActualSize1 = HeapActualSize + 1,

            % If heap size exceeds K, remove the smallest element
            if NewHeapActualSize1 > K ->
                   SmallestN = gb_trees:smallest_key(NewMinHeap1),
                   SmallestNCount = gb_trees:get(SmallestN, NewMinHeap1),

                   NewMinHeap2 = if SmallestNCount == 1 ->
                                     gb_trees:delete(SmallestN, NewMinHeap1);
                                 true ->
                                     gb_trees:update(SmallestN, fun(C) -> C - 1 end, NewMinHeap1)
                                 end,
                   NewCurrentSum2 = NewCurrentSum1 - SmallestN,
                   NewHeapActualSize2 = NewHeapActualSize1 - 1,

                   % After removal, heap size is exactly K. Calculate score.
                   Score = NewCurrentSum2 * M,
                   {NewCurrentSum2, NewMinHeap2, NewHeapActualSize2, max(MaxScore, Score)};
               NewHeapActualSize1 == K ->
                   % Heap size is exactly K. Calculate score.
                   Score = NewCurrentSum1 * M,
                   {NewCurrentSum1, NewMinHeap1, NewHeapActualSize1, max(MaxScore, Score)};
               true ->
                   % Heap size is less than K. Just continue.
                   {NewCurrentSum1, NewMinHeap1, NewHeapActualSize1, MaxScore}
            end
        end, InitialState, SortedPaired),

    FinalMaxScore.