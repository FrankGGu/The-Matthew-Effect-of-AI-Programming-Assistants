-module(flip_string).
-export([min_flips_mono_incr/1]).

min_flips_mono_incr(S) ->
    min_flips_mono_incr(S, 0, 0).

min_flips_mono_incr([], Ones, Zeros) ->
    min(Ones, Zeros);
min_flips_mono_incr([H|T], Ones, Zeros) ->
    case H of
        $0 ->
            min_flips_mono_incr(T, Ones, Zeros + 1);
        $1 ->
            min_flips_mono_incr(T, Ones + 1, Zeros)
    end.