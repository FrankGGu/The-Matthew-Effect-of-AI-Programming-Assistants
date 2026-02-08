-module(stretchy_words).
-export([expressive_words/2]).

expressive_words(Word, Words) ->
    Count = count_chars(Word),
    lists:foldl(fun(W, Acc) -> if count_chars(W) == Count -> Acc + 1; true -> Acc end end, 0, Words).

count_chars(Str) ->
    count_chars(Str, []).

count_chars([], Acc) ->
    lists:reverse(Acc);
count_chars([C | T], []) ->
    count_chars(T, [{C, 1}]);
count_chars([C | T], [{C, N} | Rest]) ->
    count_chars(T, [{C, N + 1} | Rest]);
count_chars([C | T], [H | Rest]) ->
    count_chars(T, [{C, 1} | [H | Rest]]).