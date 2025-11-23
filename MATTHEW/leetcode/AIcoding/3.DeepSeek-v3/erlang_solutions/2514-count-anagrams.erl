-module(solution).
-export([count_anagrams/1]).

count_anagrams(S) ->
    Words = string:tokens(S, " "),
    Fact = factorial(length(Words)),
    lists:foldl(fun(Word, Acc) ->
        Acc * Fact div lists:foldl(fun({_, C}, AccIn) -> AccIn * factorial(C) end, 1, count_chars(Word))
    end, 1, Words).

count_chars(Word) ->
    lists:foldl(fun(C, Acc) ->
        dict:update(C, fun(V) -> V + 1 end, 1, Acc)
    end, dict:new(), Word).

factorial(N) ->
    factorial(N, 1).

factorial(0, Acc) -> Acc;
factorial(N, Acc) -> factorial(N - 1, Acc * N).