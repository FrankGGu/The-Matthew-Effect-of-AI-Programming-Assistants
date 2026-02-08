-module(solution).
-export([sort_sentence/1]).

sort_sentence(Sentence) ->
    Words = string:tokens(Sentence, " "),
    SortedWords = lists:sort(fun({A, B}) -> element(2, A) < element(2, B) end,
                             [{string:to_integer(string:substr(W, -1)), string:trim(string:substr(W, 0, string:length(W) - 1))} || W <- Words]),
    Result = lists:map(fun({_, Word}) -> Word end, SortedWords),
    string:join(Result, " ").