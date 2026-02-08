-module(solution).
-export([count_vowel_strings/1]).

count_vowel_strings(N) ->
    lists:foldl(fun(_, Acc) -> Acc * (N + 1) div 2 end, 1, lists:seq(1, 5) div 2).