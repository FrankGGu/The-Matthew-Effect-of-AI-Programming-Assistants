-module(solution).
-export([replace_words/2]).

replace_words(Words, Sentence) ->
    WordSet = sets:from_list(Words),
    WordsList = string:tokens(Sentence, " "),
    lists:map(fun(W) -> replace_word(W, WordSet) end, WordsList)
    |> string:join(" ").

replace_word(Word, WordSet) ->
    case sets:to_list(sets:filter(fun(X) -> string:prefix(Word, X) end, WordSet)) of
        [] -> Word;
        Prefixes -> lists:nth(1, lists:sort(fun(A, B) -> string:length(A) > string:length(B) end, Prefixes))
    end.