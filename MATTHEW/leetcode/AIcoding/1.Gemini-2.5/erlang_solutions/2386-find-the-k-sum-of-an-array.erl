-module(solution).
-export([k_sum/2]).

k_sum(Nums, K) ->
    {MaxSum, AbsDiffs} = lists:foldl(fun(X, {AccSum, AccDiffs}) ->
                                         if X >= 0 -> {AccSum + X, [X | AccDiffs]};
                                            true -> {AccSum, [-X | AccDiffs]}
                                         end
                                 end, {0, []}, Nums),

    SortedAbsDiffs = lists:sort(AbsDiffs),
    N = length(SortedAbsDiffs),

    % Priority queue: {SumOfReductions, LastIdx}
    % gb_trees is ordered by key, so {Sum, LastIdx} works as a min-heap.
    PQ = gb_trees:insert({0, -1}, true, gb_trees:empty()),

    % Visited set: {SumOfReductions, LastIdx}
    Visited = sets:add_element({0, -1}, sets:empty()),

    % Find the K-th smallest reduction
    Reduction = find_kth_reduction(K, 1, PQ, Visited, SortedAbsDiffs, N),

    MaxSum - Reduction.

find_kth_reduction(K, Count, PQ, Visited, SortedAbsDiffs, N) ->
    {{Sum, LastIdx}, NewPQ} = gb_trees:take_min(PQ),

    if Count == K ->
        Sum;
    true ->
        NewPQ1 = NewPQ,
        NewVisited1 = Visited,

        % Option 1: Add the next element abs_diffs[LastIdx + 1]
        % This extends the current subsequence.
        if LastIdx + 1 < N ->
            NextElement = lists:nth(LastIdx + 1 + 1, SortedAbsDiffs), % lists:nth is 1-indexed
            NewSum1 = Sum + NextElement,
            NewIdx1 = LastIdx + 1,

            if not sets:is_element({NewSum1, NewIdx1}, NewVisited1) ->
                NewPQ2 = gb_trees:insert({NewSum1, NewIdx1}, true, NewPQ1),
                NewVisited2 = sets:add_element({NewSum1, NewIdx1}, NewVisited1);
            true ->
                NewPQ2 = NewPQ1,
                NewVisited2 = NewVisited1
            end;
        true ->
            NewPQ2 = NewPQ1,
            NewVisited2 = NewVisited1
        end,

        % Option 2: If LastIdx >= 0, replace abs_diffs[LastIdx] with abs_diffs[LastIdx + 1]
        if LastIdx >= 0 and LastIdx + 1 < N ->
            CurrentElement = lists:nth(LastIdx + 1, SortedAbsDiffs), % lists:nth is 1-indexed
            NextElement = lists:nth(LastIdx + 1 + 1, SortedAbsDiffs), % lists:nth is 1-indexed
            NewSum2 = Sum - CurrentElement + NextElement,
            NewIdx2 = LastIdx + 1,

            if not sets:is_element({NewSum2, NewIdx2}, NewVisited2) ->
                NewPQ3 = gb_trees:insert({NewSum2, NewIdx2}, true, NewPQ2),
                NewVisited3 = sets:add_element({NewSum2, NewIdx2}, NewVisited2);
            true ->
                NewPQ3 = NewPQ2,
                NewVisited3 = NewVisited2
            end;
        true ->
            NewPQ3 = NewPQ2,
            NewVisited3 = NewVisited2
        end,

        find_kth_reduction(K, Count + 1, NewPQ3, NewVisited3, SortedAbsDiffs, N)
    end.