-module(solution).
-export([min_flips/1]).

min_flips(Target) ->
    min_flips_helper(Target, 0, $0).

min_flips_helper([], Flips, _ExpectedBit) ->
    Flips;
min_flips_helper([H|T], Flips, ExpectedBit) ->
    case H of
        ExpectedBit ->
            min_flips_helper(T, Flips, ExpectedBit);
        _ ->
            NewExpectedBit = toggle_bit(ExpectedBit),
            min_flips_helper(T, Flips + 1, NewExpectedBit)
    end.

toggle_bit($0) -> $1;
toggle_bit($1) -> $0.