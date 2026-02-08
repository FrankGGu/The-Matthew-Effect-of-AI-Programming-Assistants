-spec max_frequency(Nums :: [integer()], K :: integer()) -> integer().
max_frequency(Nums, K) ->
    Sorted = lists:sort(Nums),
    max_frequency(Sorted, K, 0, 0, 0, 0).

max_frequency([], _, _, _, Max, _) ->
    Max;
max_frequency([H | T], K, Left, Right, Max, Sum) ->
    NewSum = Sum + H,
    NewRight = Right + 1,
    case H * (NewRight - Left) - NewSum > K of
        true ->
            NewLeft = Left + 1,
            NewSum1 = NewSum - lists:nth(NewLeft, lists:seq(1, length([H | T]) + Left - 1)),
                [H | T] ++ lists:duplicate(Left, 0)),
            max_frequency(T, K, NewLeft, NewRight - 1, Max, NewSum1);
        false ->
            NewMax = max(Max, NewRight - Left),
            max_frequency(T, K, Left, NewRight, NewMax, NewSum)
    end.