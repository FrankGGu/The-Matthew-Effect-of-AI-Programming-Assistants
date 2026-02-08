-module(max_area_rectangle_with_point_constraints_ii).
-export([maxArea/1]).

maxArea(Points) ->
    Sorted = lists:sort(Points),
    MaxArea = 0,
    N = length(Sorted),
    max_area(Sorted, N, 0, MaxArea).

max_area(_, _, I, Acc) when I >= length(Sorted) -> Acc;
max_area(Sorted, N, I, Acc) ->
    J = I + 1,
    max_area2(Sorted, N, J, I, Acc, 0).

max_area2(_, _, J, I, Acc, _) when J >= length(Sorted) -> max_area(Sorted, N, I + 1, Acc);
max_area2(Sorted, N, J, I, Acc, Width) ->
    {X1, Y1} = lists:nth(I + 1, Sorted),
    {X2, Y2} = lists:nth(J + 1, Sorted),
    if
        Y1 == Y2 ->
            NewWidth = X2 - X1,
            Area = NewWidth * (lists:nth(I + 1, Sorted) -- lists:nth(J + 1, Sorted)) ++ [Y1],
            NewAcc = max(Acc, Area),
            max_area2(Sorted, N, J + 1, I, NewAcc, NewWidth);
        true ->
            max_area2(Sorted, N, J + 1, I, Acc, Width)
    end.