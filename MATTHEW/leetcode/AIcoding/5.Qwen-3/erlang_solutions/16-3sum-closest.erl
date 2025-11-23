-module(three_sum_closest).
-export([three_sum_closest/1]).

three_sum_closest(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Closest = hd(Sorted) + hd(tl(Sorted)) + hd(tl(tl(Sorted))),
    three_sum_closest(Sorted, 0, Len - 1, Len - 2, Closest).

three_sum_closest(_, _, _, _, Closest) -> Closest;
three_sum_closest(Sorted, Left, Right, Index, Closest) ->
    A = lists:nth(Index, Sorted),
    B = lists:nth(Left, Sorted),
    C = lists:nth(Right, Sorted),
    Sum = A + B + C,
    NewClosest = if
        abs(Sum) < abs(Closest) -> Sum;
        true -> Closest
    end,
    if
        Sum < 0 -> three_sum_closest(Sorted, Left + 1, Right, Index, NewClosest);
        Sum > 0 -> three_sum_closest(Sorted, Left, Right - 1, Index, NewClosest);
        true -> NewClosest
    end.

three_sum_closest(Sorted, Left, Right, Index) ->
    if
        Index < 0 -> 0;
        true -> three_sum_closest(Sorted, Left, Right, Index, hd(Sorted) + hd(tl(Sorted)) + hd(tl(tl(Sorted))))
    end.