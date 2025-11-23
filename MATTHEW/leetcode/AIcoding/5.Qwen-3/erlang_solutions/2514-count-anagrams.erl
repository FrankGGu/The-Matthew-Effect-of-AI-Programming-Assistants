-module(count_anagrams).
-export([is_anagram/2]).

is_anagram(S, T) ->
    lists:sort(S) == lists:sort(T).