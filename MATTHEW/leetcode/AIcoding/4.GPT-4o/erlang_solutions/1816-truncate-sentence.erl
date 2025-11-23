-module(solution).
-export([truncate_sentence/2]).

truncate_sentence(Sentence, k) ->
    Words = string:tokens(Sentence, " "),
    WordsList = lists:sublist(Words, k),
    string:join(WordsList, " ").