-module(solution).
-export([is_anagram/2]).

is_anagram(S, T) ->
    lists:sort(string:to_list(S)) =:= lists:sort(string:to_list(T)).