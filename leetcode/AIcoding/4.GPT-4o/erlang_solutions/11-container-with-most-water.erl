-spec max_area(Height :: [integer()]) -> integer().
max_area(Height) -> max_area(Height, 0, 0, length(Height) - 1).

max_area(_, MaxArea, Left, Right) when Left >= Right -> MaxArea;
max_area(Height, MaxArea, Left, Right) ->
    CurrentArea = min(list:nth(Left + 1, Height), list:nth(Right + 1, Height)) * (Right - Left),
    NewMaxArea = max(MaxArea, CurrentArea),
    if 
        list:nth(Left + 1, Height) < list:nth(Right + 1, Height) -> 
            max_area(Height, NewMaxArea, Left + 1, Right);
        true -> 
            max_area(Height, NewMaxArea, Left, Right - 1)
    end.
