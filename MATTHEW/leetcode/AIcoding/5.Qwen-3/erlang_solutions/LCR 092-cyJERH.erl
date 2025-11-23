-module(solve).
-export([min_flips_mono_incr/1]).

min_flips_mono_incr(S) ->
    min_flips_mono_incr(S, 0, 0).

min_flips_mono_incr([], _, Acc) ->
    Acc;
min_flips_mono_incr([H | T], prev, Acc) ->
    case H of
        $0 ->
            if
                prev == 0 ->
                    min_flips_mono_incr(T, 0, Acc);
                true ->
                    min_flips_mono_incr(T, 0, Acc + 1)
            end;
        $1 ->
            min_flips_mono_incr(T, 1, Acc)
    end.