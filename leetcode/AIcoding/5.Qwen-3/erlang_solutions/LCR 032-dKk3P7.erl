-module(valid_anagram).
-export([is_anagram/2]).

is_anagram(S, T) ->
    erlang:length(S) == erlang:length(T) andalso
    lists:sort(S) == lists:sort(T).