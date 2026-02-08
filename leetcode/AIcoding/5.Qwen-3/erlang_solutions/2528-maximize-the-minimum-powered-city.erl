-module(maximize_the_minimum_powered_city).
-export([maximizeTheMinimum/1]).

maximizeTheMinimum(Cities) ->
    CitiesList = lists:sort(Cities),
    N = length(CitiesList),
    Left = 0,
    Right = lists:last(CitiesList),
    solve(CitiesList, N, Left, Right).

solve(_, _, Left, Right) when Left >= Right ->
    Left;
solve(Cities, N, Left, Right) ->
    Mid = (Left + Right) div 2,
    if
        is_possible(Cities, N, Mid) ->
            solve(Cities, N, Mid + 1, Right);
        true ->
            solve(Cities, N, Left, Mid - 1)
    end.

is_possible([], _, _) ->
    true;
is_possible([_], _, _) ->
    true;
is_possible([A | [B | T]], N, MinPower) ->
    Count = 1,
    Current = A,
    Next = B,
    if
        Next - Current >= MinPower ->
            is_possible([Next | T], N, MinPower);
        true ->
            is_possible([B | T], N, MinPower)
    end.