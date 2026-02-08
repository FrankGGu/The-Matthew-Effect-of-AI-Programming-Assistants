-module(solution).
-export([categorize_box/2]).

categorize_box(Length, Width) ->
    Volume = Length * Width,
    if
        (Length >= 10^9 orelse Width >= 10^9 orelse Volume >= 10^9) andalso (Length <= 10^4 andalso Width <= 10^4) -> "Both";
        (Length >= 10^9 orelse Width >= 10^9 orelse Volume >= 10^9) -> "Heavy";
        (Length <= 10^4 andalso Width <= 10^4) -> "Bulky";
        true -> "Neither"
    end.