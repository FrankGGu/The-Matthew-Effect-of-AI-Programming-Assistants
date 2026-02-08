-spec three_sum_closest(Nums :: [integer()], Target :: integer()) -> integer().
three_sum_closest(Nums, Target) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    three_sum_closest(Sorted, Target, Len, 10000000).

three_sum_closest([], _, _, Closest) -> Closest;
three_sum_closest([H | T], Target, Len, Closest) ->
    NewClosest = two_sum_closest(T, H, Target, Len, Closest),
    three_sum_closest(T, Target, Len, NewClosest).

two_sum_closest(Nums, First, Target, Len, Closest) ->
    two_sum_closest(Nums, First, Target, 1, Len - 1, Closest).

two_sum_closest(_, _, _, Left, Right, Closest) when Left >= Right -> Closest;
two_sum_closest(Nums, First, Target, Left, Right, Closest) ->
    Sum = First + lists:nth(Left, Nums) + lists:nth(Right, Nums),
    NewClosest = case abs(Sum - Target) < abs(Closest - Target) of
        true -> Sum;
        false -> Closest
    end,
    if
        Sum < Target -> two_sum_closest(Nums, First, Target, Left + 1, Right, NewClosest);
        Sum > Target -> two_sum_closest(Nums, First, Target, Left, Right - 1, NewClosest);
        true -> Sum
    end.