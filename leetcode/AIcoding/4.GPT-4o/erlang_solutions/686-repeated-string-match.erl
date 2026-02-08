-module(solution).
-export([repeated_string_match/2]).

repeated_string_match(StrA, StrB) ->
    {LenA, LenB} = {length(StrA), length(StrB)},
    MaxRepeats = (LenB div LenA) + 2,
    lists:foldl(fun(N, Acc) ->
        case lists:prefix(StrB, Acc) of
            true -> N;
            false -> Acc ++ StrA
        end
    end, "", lists:seq(1, MaxRepeats).