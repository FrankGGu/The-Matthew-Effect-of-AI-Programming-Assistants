-module(surfaces).
-export([surface_area/1]).

surface_area(Grid) ->
    Rows = length(Grid),
    if
        Rows == 0 -> 0;
        true ->
            Cols = length(hd(Grid)),
            surface_area(Grid, 0, 0, Rows, Cols, 0)
    end.

surface_area(_, R, C, R, _, Acc) -> Acc;
surface_area(Grid, R, C, MaxR, MaxC, Acc) ->
    Value = lists:nth(R+1, Grid),
    Cell = lists:nth(C+1, Value),
    if
        Cell == 0 -> surface_area(Grid, R, C+1, MaxR, MaxC, Acc);
        true ->
            Top = if R > 0 -> lists:nth(R, Grid), lists:nth(C+1, lists:nth(R, Grid)) end,
            Bottom = if R < MaxR - 1 -> lists:nth(R+2, Grid), lists:nth(C+1, lists:nth(R+2, Grid)) end,
            Left = if C > 0 -> lists:nth(C, Value) end,
            Right = if C < MaxC - 1 -> lists:nth(C+2, Value) end,
            Add = 2 + 
                  (if R == 0 or (Top == 0) -> 0; true -> max(0, Cell - Top) end) +
                  (if R == MaxR - 1 or (Bottom == 0) -> 0; true -> max(0, Cell - Bottom) end) +
                  (if C == 0 or (Left == 0) -> 0; true -> max(0, Cell - Left) end) +
                  (if C == MaxC - 1 or (Right == 0) -> 0; true -> max(0, Cell - Right) end),
            surface_area(Grid, R, C+1, MaxR, MaxC, Acc + Add)
    end.