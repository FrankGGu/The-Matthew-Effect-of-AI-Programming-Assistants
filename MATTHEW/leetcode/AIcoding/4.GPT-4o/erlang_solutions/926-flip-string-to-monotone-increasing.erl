-module(solution).
-export([min_flips_mono_incr/1]).

min_flips_mono_incr(S) ->
    flip_count(S, 0, 0).

flip_count([], Count, _) -> Count;
flip_count([H | T], Count, Prev) ->
    NewCount = if
        H == $0 -> Prev;
        true -> Prev + 1
    end,
    flip_count(T, NewCount, NewCount).