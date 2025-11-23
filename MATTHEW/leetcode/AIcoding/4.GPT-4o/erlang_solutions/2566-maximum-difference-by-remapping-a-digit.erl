-module(solution).
-export([maximumDifference/1]).

maximumDifference(N) ->
    S = integer_to_list(N),
    Min = remap(S, 0),
    Max = remap(S, 9),
    Max - Min.

remap(S, NewDigit) ->
    case lists:prefix(S, "0") of
        true -> 
            remap_digits(S, NewDigit, false);
        false -> 
            remap_digits(S, NewDigit, true)
    end.

remap_digits([], _, _) -> 
    0;
remap_digits([H | T], NewDigit, First) ->
    NewH = if First andalso H =:= $0 -> 
                NewDigit;
            true -> 
                H
            end,
    NewH + 10 * remap_digits(T, NewDigit, false).