-module(solution).
-export([vowel_strings/2]).

is_vowel(C) ->
    lists:member(C, "aeiou").

vowel_strings(Words, Queries) ->
    Prefix = lists:foldl(fun(Word, Acc) ->
        case is_vowel(hd(Word)) andalso is_vowel(lists:last(Word)) of
            true -> [hd(Acc) + 1 | tl(Acc)];
            false -> [hd(Acc) | tl(Acc)]
        end
    end, [0], Words),
    PrefixSum = lists:reverse(lists:foldl(fun(X, Acc) -> [X + hd(Acc) | tl(Acc)] end, [0], Prefix)),
    lists:map(fun([L, R]) -> 
        lists:nth(R + 2, PrefixSum) - lists:nth(L + 1, PrefixSum)
    end, Queries).