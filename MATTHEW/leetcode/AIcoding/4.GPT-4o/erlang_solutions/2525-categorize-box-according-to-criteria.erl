-module(solution).
-export([categorize_box/3]).

categorize_box(Length, Width, Height) ->
    Volume = Length * Width * Height,
    IsHeavy = if Volume > 1000000000 -> true; _ -> false end,
    IsBulky = if Length >= 10 or Width >= 10 or Height >= 10 or Volume >= 10000000 -> true; _ -> false end,
    case {IsHeavy, IsBulky} of
        {true, true} -> "Heavy and Bulky";
        {true, false} -> "Heavy";
        {false, true} -> "Bulky";
        {false, false} -> "Light"
    end.