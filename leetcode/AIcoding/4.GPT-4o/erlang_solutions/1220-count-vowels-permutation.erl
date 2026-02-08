-module(solution).
-export([count_vowel_permutation/1]).

count_vowel_permutation(N) ->
    Vowels = [1, 1, 1, 1, 1],
    lists:foldl(fun(_, Acc) ->
        lists:map(fun(X) -> 
            (lists:nth(1, X) + lists:nth(2, X) + lists:nth(3, X) + lists:nth(4, X) + lists:nth(5, X)) rem 1000000007
        end, 
        [Vowels, Vowels, Vowels, Vowels, Vowels]) 
    end, Vowels, lists:seq(1, N - 1).