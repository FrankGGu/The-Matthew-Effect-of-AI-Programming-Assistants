-module(solution).
-export([remove_occurrences/2]).

remove_occurrences(S, Part) ->
    case string:str(S, Part) of
        0 -> S;
        Pos ->
            PartLen = string:len(Part),
            Prefix = string:substr(S, 1, Pos - 1),
            Suffix = string:substr(S, Pos + PartLen),
            remove_occurrences(Prefix ++ Suffix, Part)
    end.