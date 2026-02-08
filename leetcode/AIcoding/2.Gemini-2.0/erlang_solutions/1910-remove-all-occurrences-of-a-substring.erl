-module(remove_substring).
-export([removeOccurrences/2]).

removeOccurrences(S, Part) ->
    removeOccurrences_helper(S, Part, []).

removeOccurrences_helper("", _, Acc) ->
    lists:reverse(Acc);
removeOccurrences_helper(S, Part, Acc) ->
    case string:str(S, Part) of
        nomatch ->
            lists:reverse(Acc) ++ S;
        Pos ->
            Prefix = string:sub_string(S, 1, Pos - 1),
            Suffix = string:sub_string(S, Pos + string:len(Part), string:len(S)),
            removeOccurrences_helper(Prefix, Part, Acc ++ Suffix)
    end.