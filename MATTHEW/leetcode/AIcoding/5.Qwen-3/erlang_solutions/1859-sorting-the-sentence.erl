-module(solution).
-export([sortSentence/1]).

sortSentence(S) ->
    Words = string:split(S, " "),
    Sorted = lists:sort(fun(A, B) -> getNumber(A) =< getNumber(B) end, Words),
    lists:map(fun(W) -> string:sub_string(W, 1, string:length(W) - 1) end, Sorted).

getNumber(W) ->
    LastChar = string:right(W, 1),
    case string:to_integer(LastChar) of
        {N, ""} -> N;
        _ -> 0
    end.