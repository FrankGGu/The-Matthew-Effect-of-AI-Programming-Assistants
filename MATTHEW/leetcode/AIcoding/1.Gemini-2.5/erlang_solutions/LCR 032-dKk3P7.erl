-module(solution).
-export([is_anagram/2]).

is_anagram(S, T) ->
    length(S) == length(T) andalso lists:sort(S) == lists:sort(T).