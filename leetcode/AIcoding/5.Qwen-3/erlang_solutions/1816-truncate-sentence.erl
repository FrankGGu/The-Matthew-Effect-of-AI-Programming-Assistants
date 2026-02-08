-module(truncate_sentence).
-export([truncate/2]).

truncate(Sentence, k) ->
    Words = string:split(Sentence, " "),
    Truncated = lists:sublist(Words, k),
    string:join(Truncated, " ").