-module(solution).
-export([replace_words/2]).

replace_words(Roots, Sentence) ->
    RootsList = string:split(Roots, ","),
    RootsSet = sets:from_list(RootsList),
    SentencesList = string:split(Sentence, " "),
    NewSentencesList = [replace_word(W, RootsSet) || W <- SentencesList],
    string:join(NewSentencesList, " ").

replace_word(Word, RootsSet) ->
    MinPrefix = lists:min([Prefix || Prefix <- sets:to_list(RootsSet), string:prefix(Word, Prefix)], 
                          fun(A, B) -> string:len(A) < string:len(B) end),
    case MinPrefix of
        undefined -> Word;
        _ -> MinPrefix
    end.