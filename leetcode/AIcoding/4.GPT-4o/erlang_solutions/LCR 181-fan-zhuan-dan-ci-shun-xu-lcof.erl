-module(solution).
-export([reverseWords/1]).

reverseWords(S) ->
    S1 = string:trim(S),
    Words = string:tokens(S1, " "),
    lists:reverse(Words),
    lists:flatten(lists:map(fun Word -> Word ++ " " end, Words)).