-spec count_subarrays(Nums :: [integer()], K :: integer()) -> integer().
count_subarrays(Nums, K) ->
    Max = lists:max(Nums),
    count_subarrays(Nums, K, Max, 0, 0, 0, 0).

count_subarrays([], _, _, _, _, Count, _) ->
    Count;
count_subarrays([H | T], K, Max, Left, Right, Count, MaxCount) ->
    NewRight = Right + 1,
    NewMaxCount = if H == Max -> MaxCount + 1; true -> MaxCount end,
    if
        NewMaxCount >= K ->
            NewLeft = move_left(Left, NewRight, Nums, Max, K, NewMaxCount),
            NewCount = Count + (NewLeft + 1),
            count_subarrays(T, K, Max, NewLeft, NewRight, NewCount, NewMaxCount);
        true ->
            count_subarrays(T, K, Max, Left, NewRight, Count, NewMaxCount)
    end.

move_left(Left, Right, Nums, Max, K, MaxCount) ->
    case MaxCount >= K of
        true ->
            case lists:nth(Left + 1, Nums) == Max of
                true ->
                    if
                        MaxCount - 1 >= K -> move_left(Left + 1, Right, Nums, Max, K, MaxCount - 1);
                        true -> Left
                    end;
                false -> move_left(Left + 1, Right, Nums, Max, K, MaxCount)
            end;
        false -> Left
    end.