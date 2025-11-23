-module(solution).
-export([removeOccurrences/2]).

removeOccurrences(S, T) ->
    removeOccurrencesHelper(S, T, []).

removeOccurrencesHelper([], _T, Acc) ->
    lists:reverse(Acc);
removeOccurrencesHelper(S, T, Acc) ->
    case string:prefix(S, T) of
        true ->
            removeOccurrencesHelper(string:substr(S, string:length(T) + 1), T, Acc);
        false ->
            removeOccurrencesHelper(string:substr(S, 2), T, [string:substr(S, 1, 1) | Acc])
    end.