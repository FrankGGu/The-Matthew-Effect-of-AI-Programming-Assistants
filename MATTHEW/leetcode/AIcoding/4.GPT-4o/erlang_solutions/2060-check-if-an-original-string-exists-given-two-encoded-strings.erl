-module(solution).
-export([find_original_string/2]).

find_original_string(S1, S2) ->
    {L1, L2} = {length(S1), length(S2)},
    {X1, X2} = {string:to_integer(S1), string:to_integer(S2)},
    case (L1 + L2) rem 2 of
        0 -> 
            {X1, X2};
        _ -> 
            false
    end.