-spec largest_rectangle_area(Heights :: [integer()]) -> integer().
largest_rectangle_area(Heights) ->
    Stack = [],
    MaxArea = 0,
    {_, Result} = calculate_area(Heights, Stack, MaxArea),
    Result.

calculate_area([], [], MaxArea) ->
    {[], MaxArea};
calculate_area([], Stack, MaxArea) ->
    {Height, NewStack} = pop(Stack),
    Width = case NewStack of
                [] -> length(Stack) + 1;
                _ -> length(Stack) - length(NewStack)
            end,
    Area = Height * Width,
    NewMaxArea = max(Area, MaxArea),
    calculate_area([], NewStack, NewMaxArea);
calculate_area([H | T], Stack, MaxArea) ->
    case Stack of
        [] ->
            NewStack = push(H, 1, Stack),
            calculate_area(T, NewStack, MaxArea);
        [{TopH, TopI} | _] ->
            if
                H >= TopH ->
                    NewStack = push(H, TopI + 1, Stack),
                    calculate_area(T, NewStack, MaxArea);
                true ->
                    {Height, NewStack} = pop(Stack),
                    Width = case NewStack of
                                [] -> TopI;
                                _ -> TopI - element(2, hd(NewStack))
                            end,
                    Area = Height * Width,
                    NewMaxArea = max(Area, MaxArea),
                    calculate_area([H | T], NewStack, NewMaxArea)
            end
    end.

push(Val, Index, Stack) ->
    [{Val, Index} | Stack].

pop(Stack) ->
    [H | T] = Stack,
    {element(1, H), T}.