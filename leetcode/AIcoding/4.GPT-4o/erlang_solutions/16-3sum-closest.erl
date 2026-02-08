-spec three_sum_closest(Nums :: [integer()], Target :: integer()) -> integer().
three_sum_closest(Nums, Target) ->
    SortedNums = lists:sort(Nums),
    three_sum_closest(SortedNums, Target, 0, infinity).

three_sum_closest([], _, Closest, _) -> Closest;
three_sum_closest([H | T], Target, Closest, _) ->
    three_sum_closest(T, Target, Closest, H, T, Target).

three_sum_closest([], _, Closest, _, _, _) -> Closest;
three_sum_closest([H | T], Target, Closest, PrevH, PrevT) ->
    Sum = PrevH + PrevT + H,
    UpdatedClosest = if
                      abs(Sum - Target) < abs(Closest - Target) -> Sum;
                      true -> Closest
                    end,
    three_sum_closest(T, Target, UpdatedClosest,PrevSum, New .
