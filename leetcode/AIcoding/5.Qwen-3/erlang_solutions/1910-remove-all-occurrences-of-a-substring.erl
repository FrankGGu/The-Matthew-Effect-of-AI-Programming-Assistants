-module(remove_all_occurrences_of_a_substring).
-export([removeOccurrences/2]).

removeOccurrences(S, Sub) ->
    removeOccurrences(S, Sub, []).

removeOccurrences([], _, Acc) ->
    lists:reverse(Acc);
removeOccurrences(S, Sub, Acc) ->
    case string:find(S, Sub) of
        {match, Pos} ->
            Prefix = lists:sublist(S, Pos),
            S1 = lists:subtail(S, Pos + length(Sub)),
            removeOccurrences(S1, Sub, [Prefix | Acc]);
        nomatch ->
            lists:reverse([S | Acc])
    end.