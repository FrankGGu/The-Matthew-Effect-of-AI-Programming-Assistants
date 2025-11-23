-spec count_subarrays(Nums :: [integer()]) -> integer().
count_subarrays(Nums) ->
    {Count, _} = lists:foldl(fun(Num, {Acc, Deque}) ->
        {NewDeque, Left} = adjust_deque(Deque, Num, Nums),
        NewAcc = Acc + (length(NewDeque) - Left + 1,
        {NewAcc, NewDeque}
    end, {0, []}, Nums),
    Count.

adjust_deque(Deque, Num, Nums) ->
    {MinDeque, LeftMin} = adjust_min_deque(Deque, Num, Nums),
    {MaxDeque, LeftMax} = adjust_max_deque(MinDeque, Num, Nums),
    {MaxDeque, max(LeftMin, LeftMax)}.

adjust_min_deque(Deque, Num, Nums) ->
    adjust_deque_helper(Deque, Num, Nums, fun(A, B) -> A > B end).

adjust_max_deque(Deque, Num, Nums) ->
    adjust_deque_helper(Deque, Num, Nums, fun(A, B) -> A < B end).

adjust_deque_helper(Deque, Num, Nums, Compare) ->
    {NewDeque, Left} = lists:foldl(fun(Idx, {D, L}) ->
        case Compare(lists:nth(Idx + 1, Nums), Num) of
            true -> {D, L};
            false -> {D ++ [Idx], L}
        end
    end, {[], 0}, Deque),
    {[Num | NewDeque], Left}.