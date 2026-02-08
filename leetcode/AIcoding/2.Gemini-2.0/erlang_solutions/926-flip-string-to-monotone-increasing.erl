-module(flip_string_to_monotone_increasing).
-export([min_flips/1]).

min_flips(S) ->
    min_flips_helper(S, 0, 0).

min_flips_helper([], Ones, Flips) ->
    min(Ones, Flips);
min_flips_helper([C|Rest], Ones, Flips) ->
    case C of
        48 -> % '0'
            min_flips_helper(Rest, Ones, Flips);
        49 -> % '1'
            min_flips_helper(Rest, Ones + 1, min(Ones, Flips) + 1)
    end.