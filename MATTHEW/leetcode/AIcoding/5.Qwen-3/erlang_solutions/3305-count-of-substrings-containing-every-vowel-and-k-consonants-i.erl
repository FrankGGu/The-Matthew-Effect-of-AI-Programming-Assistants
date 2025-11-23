-module(solution).
-export([solve/1]).

solve(S) ->
    Vowels = "aeiou",
    Count = 0,
    Len = length(S),
    lists:foldl(fun(I, Acc) ->
        lists:foldl(fun(J, Acc2) ->
            if J >= I ->
                Sub = string:substr(S, I+1, J-I),
                VowelCount = count_vowels(Sub),
                ConsonantCount = length(Sub) - VowelCount,
                if
                    VowelCount == 5 andalso ConsonantCount == 0 ->
                        Acc2 + 1;
                    true ->
                        Acc2
                end;
            true ->
                Acc2
        end
    end, Count, lists:seq(0, Len-1)), 0).

count_vowels(S) ->
    lists:foldl(fun(C, Acc) ->
        if lists:member(C, "aeiou") -> Acc + 1;
           true -> Acc
        end
    end, 0, S).