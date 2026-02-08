-module(goat_latin).
-export([goat_latin/1]).

goat_latin(S) ->
    Words = string:tokens(S, " "),
    goat_latin(Words, 1).

goat_latin([], _) ->
    "";
goat_latin([Word | Rest], N) ->
    FirstChar = string:sub_word(Word, 1),
    LowerFirst = string:to_lower(FirstChar),
    case lists:member(LowerFirst, [$a, $e, $i, $o, $u]) of
        true ->
            NewWord = Word ++ "ma" ++ integer_to_list(N);
        false ->
            NewWord = string:sub_word(Word, 2) ++ FirstChar ++ "ma" ++ integer_to_list(N)
    end,
    if
        Rest == [] ->
            NewWord;
        true ->
            NewWord ++ " " ++ goat_latin(Rest, N + 1)
    end.