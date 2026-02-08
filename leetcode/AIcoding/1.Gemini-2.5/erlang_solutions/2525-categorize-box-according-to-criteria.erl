-module(solution).
-export([categorizeBox/4]).

categorizeBox(Length, Width, Height, Mass) ->
    Volume = Length * Width * Height,
    IsBulky = (Length >= 10000 orelse Width >= 10000 orelse Height >= 10000 orelse Volume >= 1000000000),
    IsHeavy = (Mass >= 100),

    case {IsBulky, IsHeavy} of
        {true, true} -> "Both";
        {true, false} -> "Bulky";
        {false, true} -> "Heavy";
        {false, false} -> "Neither"
    end.