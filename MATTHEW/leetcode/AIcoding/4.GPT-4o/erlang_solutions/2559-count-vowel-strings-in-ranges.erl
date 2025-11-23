-module(solution).
-export([vowel_strings/2]).

vowel_strings(Strings, Ranges) ->
    VowelCounts = lists:map(fun(S) -> count_vowels(S) end, Strings),
    PrefixSums = lists:scanl(fun(X, Acc) -> X + Acc end, 0, VowelCounts),
    lists:map(fun({Start, End}) -> PrefixSumsEnd - PrefixSumsStart 
                end, 
                lists:map(fun({S, E}) -> {S, E + 1} end, Ranges)).

count_vowels(String) ->
    lists:foldl(fun(C, Acc) -> if 
        C == $a; C == $e; C == $i; C == $o; C == $u -> Acc + 1;
        true -> Acc
    end end, 0, String).