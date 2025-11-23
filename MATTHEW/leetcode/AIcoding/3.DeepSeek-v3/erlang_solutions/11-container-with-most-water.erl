-spec max_area(Height :: [integer()]) -> integer().
max_area(Height) ->
    max_area(Height, 0, length(Height) - 1, 0).

max_area(Height, Left, Right, Max) when Left < Right ->
    H1 = lists:nth(Left + 1, Height),
    H2 = lists:nth(Right + 1, Height),
    Current = (Right - Left) * min(H1, H2),
    NewMax = max(Max, Current),
    if
        H1 < H2 -> max_area(Height, Left + 1, Right, NewMax);
        true -> max_area(Height, Left, Right - 1, NewMax)
    end;
max_area(_Height, _Left, _Right, Max) ->
    Max.