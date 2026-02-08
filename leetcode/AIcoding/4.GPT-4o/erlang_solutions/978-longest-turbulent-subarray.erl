-module(solution).
-export([max_turbulence_size/1]).

max_turbulence_size(A) ->
    MaxLen = length(A),
    case MaxLen of
        0 -> 0;
        1 -> 1;
        _ ->
            max_turbulence(A, MaxLen, 1, 1)
    end.

max_turbulence([], _, _, Max) -> Max;
max_turbulence([_], _, _, Max) -> Max;
max_turbulence([X, Y | Rest], Prev, CurrLen, Max) ->
    NewLen = case (X < Y, Y < Prev) of
        {true, true} -> CurrLen + 1;
        {false, false} -> 1;
        {true, false} -> 1;
        {false, true} -> CurrLen + 1
    end,
    max_turbulence([Y | Rest], Y, NewLen, max(Max, NewLen));
max_turbulence([_ | Rest], Prev, CurrLen, Max) ->
    max_turbulence(Rest, Prev, CurrLen, Max).