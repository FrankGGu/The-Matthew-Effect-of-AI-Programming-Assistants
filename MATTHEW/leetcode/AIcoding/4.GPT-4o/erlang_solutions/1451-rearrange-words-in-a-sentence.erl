-module(solution).
-export([arrangeWords/1]).

arrangeWords(Sentence) ->
    Words = string:tokens(Sentence, " "),
    SortedWords = lists:sort(fun(A, B) -> string:length(A) < string:length(B) end, Words),
    FormattedWords = lists:map(fun(W) -> string:to_lower(W) end, SortedWords),
    Result = string:join(FormattedWords, " "),
    UpperFirst = string:substr(Result, 1, 1) ++ string:substr(Result, 2, string:length(Result) - 1),
    UpperFirst.