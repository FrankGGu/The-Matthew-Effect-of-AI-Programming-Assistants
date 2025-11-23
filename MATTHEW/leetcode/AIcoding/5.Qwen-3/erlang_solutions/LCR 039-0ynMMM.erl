-module(largest_rectangle_area).
-export([largestRectangleArea/1]).

largestRectangleArea(Heights) ->
    largest_rectangle_area(Heights, -1, [], 0).

largest_rectangle_area([], _, _, Max) ->
    Max;
largest_rectangle_area([H | T], Index, Stack, Max) ->
    case Stack of
        [] ->
            largest_rectangle_area(T, Index + 1, [{H, Index + 1}], Max);
        [{TopH, TopIndex} | _] when H > TopH ->
            largest_rectangle_area(T, Index + 1, [{H, Index + 1} | Stack], Max);
        _ ->
            {NewStack, NewMax} = pop_stack(Stack, H, Index + 1, Max),
            largest_rectangle_area([H | T], Index + 1, NewStack, NewMax)
    end.

pop_stack([], _, _, Max) ->
    {[], Max};
pop_stack([{H, I} | Stack], CurrentH, Index, Max) ->
    Width = Index - I,
    Area = H * Width,
    NewMax = max(Max, Area),
    pop_stack(Stack, CurrentH, Index, NewMax).