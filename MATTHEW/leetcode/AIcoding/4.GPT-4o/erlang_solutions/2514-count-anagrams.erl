-module(solution).
-export([count_anagrams/1]).

count_anagrams(Words) ->
    WordsList = string:tokens(Words, " "),
    Lists = lists:map(fun Word -> lists:sort(string:to_list(Word)) end, WordsList),
    UniqueAnagrams = lists:usort(Lists),
    length(UniqueAnagrams).