-module(solution).
-export([minimum_substrings/2]).

minimum_substrings(S, Target) ->
    case Target of
        "" -> 0;
        _ ->
            case string:str(S, Target) of
                0 -> -1;
                _ -> 1
            end
    end.