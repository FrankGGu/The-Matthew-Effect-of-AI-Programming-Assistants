-module(solution).
-export([minimumDeviation/1]).

minimumDeviation(Nums) ->
    % Step 1: Initialize priority queue (using gb_trees as a frequency map) and min_val.
    % Transform odd numbers by multiplying by 2. All numbers in the PQ will be even initially.
    % MinVal tracks the smallest element currently in the priority queue.
    {PQ, MinVal} = lists:foldl(
        fun(Num, {AccPQ, AccMinVal}) ->
            TransformedNum = if Num rem 2 == 1 -> Num * 2; true -> Num end,
            NewPQ = gb_trees:update_counter(TransformedNum, 1, AccPQ),
            {NewPQ, min(AccMinVal, TransformedNum)}
        end,
        {gb_trees:empty(), (1 bsl 60)}, % Use a large number for initial infinity
        Nums
    ),

    % Step 2: Initialize min_deviation with the deviation of the initial state.
    {InitialMax, _} = gb_trees:max(PQ),
    MinDeviation = InitialMax - MinVal,

    % Step 3: Loop (recursively) while the maximum element in the PQ is even.
    % In each step, divide the maximum even element by 2, update PQ, MinVal, and MinDeviation.
    solve(PQ, MinVal, MinDeviation).

solve(PQ, MinVal, MinDeviation) ->
    % Get the current maximum element from the priority queue.
    % PQ is guaranteed not to be empty because Nums has at least 2 elements.
    {CurrentMax, Count} = gb_trees:max(PQ),

    if CurrentMax rem 2 == 1 ->
        % If the current maximum element is odd, we cannot divide it further.
        % Multiplying it by 2 would only increase the deviation.
        % So, this is the best deviation we can achieve along this path.
        MinDeviation;
    true ->
        % Remove CurrentMax from PQ (decrement its count or delete if count is 1).
        NewPQ1 = if Count == 1 -> gb_trees:delete(CurrentMax, PQ);
                    true -> gb_trees:update_counter(CurrentMax, -1, PQ)
                 end,

        % Divide CurrentMax by 2.
        NewVal = CurrentMax div 2,

        % Add NewVal to PQ (increment its count).
        NewPQ = gb_trees:update_counter(NewVal, 1, NewPQ1),

        % Update MinVal with the new minimum element encountered.
        NewMinVal = min(MinVal, NewVal),

        % Update MinDeviation with the deviation of the new state.
        % NewPQ is guaranteed not to be empty.
        {UpdatedMax, _} = gb_trees:max(NewPQ),
        NewMinDeviation = min(MinDeviation, UpdatedMax - NewMinVal),

        % Recurse with the updated state.
        solve(NewPQ, NewMinVal, NewMinDeviation)
    end.