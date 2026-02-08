-module(repeated_string_match).
-export([repeated_string_match/2]).

repeated_string_match(A, B) ->
    LenA = length(A),
    LenB = length(B),
    MaxRepeats = ceil(LenB / LenA) + 1,
    Repeated = lists:flatten(lists:duplicate(MaxRepeats, A)),
    case string:str(Repeated, B) of
        0 -> -1;
        _ -> trunc((string:str(Repeated, B) - 1) / LenA) + 1
    end.