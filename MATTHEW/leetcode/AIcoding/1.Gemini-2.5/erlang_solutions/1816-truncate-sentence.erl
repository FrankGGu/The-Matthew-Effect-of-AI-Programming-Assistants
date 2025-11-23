-module(solution).
-export([truncate_sentence/2]).

truncate_sentence(S, K) ->
    Words = string:tokens(S, " "),
    TruncatedWords = lists:sublist(Words, K),
    string:join(TruncatedWords, " ").