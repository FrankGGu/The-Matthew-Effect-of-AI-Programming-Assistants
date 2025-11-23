-spec largest_rectangle_area(Heights :: [integer()]) -> integer().
largest_rectangle_area(Heights) ->
    Stack = [],
    MaxArea = 0,
    {_, Result} = calculate_area(Heights, Stack, MaxArea),
    Result.

calculate_area([], [], MaxArea) ->
    {[], MaxArea};
calculate_area([], Stack, MaxArea) ->
    {Height, _} = hd(Stack),
    {NewStack, NewMaxArea} = pop_stack(Stack, length(Stack),
    calculate_area([], NewStack, max(MaxArea, Height * length(Stack)));
calculate_area([H | T], Stack, MaxArea) ->
    case Stack of
        [] ->
            calculate_area(T, [{H, 1} | Stack], MaxArea);
        [{TopH, TopW} | _] ->
            if
                H > TopH ->
                    calculate_area(T, [{H, 1} | Stack], MaxArea);
                H == TopH ->
                    {NewH, NewW} = {TopH, TopW + 1},
                    calculate_area(T, [{NewH, NewW} | tl(Stack)], MaxArea);
                true ->
                    {NewStack, NewMaxArea} = pop_stack(Stack, 0),
                    calculate_area([H | T], NewStack, max(MaxArea, NewMaxArea))
            end
    end.

pop_stack(Stack, Width) ->
    {Height, TopW} = hd(Stack),
    NewWidth = Width + TopW,
    NewMaxArea = Height * NewWidth,
    NewStack = tl(Stack),
    case NewStack of
        [] ->
            {NewStack, NewMaxArea};
        [{NewTopH, NewTopW} | _] ->
            if
                Height =< NewTopH ->
                    pop_stack(NewStack, NewWidth);
                true ->
                    {NewStack, NewMaxArea}
            end
    end.