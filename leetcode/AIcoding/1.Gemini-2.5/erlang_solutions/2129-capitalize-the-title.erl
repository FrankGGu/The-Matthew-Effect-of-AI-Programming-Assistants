-module(solution).
-export([capitalizeTitle/1]).

capitalizeTitle(Title) ->
    Words = string:tokens(Title, " "),
    ProcessedWords = lists:map(fun process_word/1, Words),
    string:join(ProcessedWords, " ").

process_word(Word) ->
    Len = string:len(Word),
    if
        Len =< 2 ->
            string:to_lower(Word);
        true ->
            [H | T] = Word,
            string:to_upper([H]) ++ string:to_lower(T)
    end.