-module(solution).
-export([prefixCount/2]).

prefixCount(Words, Prefix) ->
    prefixCount(Words, Prefix, 0).

prefixCount([], _, Count) ->
    Count;
prefixCount([Word | Rest], Prefix, Count) ->
    case string:starts_with(Word, Prefix) of
        true ->
            prefixCount(Rest, Prefix, Count + 1);
        false ->
            prefixCount(Rest, Prefix, Count)
    end.