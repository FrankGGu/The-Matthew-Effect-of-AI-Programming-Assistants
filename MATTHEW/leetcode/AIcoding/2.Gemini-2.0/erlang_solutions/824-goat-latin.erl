-module(goat_latin).
-export([to_goat_latin/1]).

to_goat_latin(S) ->
    Words = string:tokens(S, " "),
    lists:foldl(
        fun(Word, {Acc, Index}) ->
            {NewWord, NewIndex} = transform_word(Word, Index),
            {lists:append(Acc, NewWord ++ " "), NewIndex}
        end,
        {[], 1},
        Words
    ).

transform_word(Word, Index) ->
    Vowels = "aeiouAEIOU",
    case string:chr(Vowels, string:code_point(Word, 1)) of
        0 ->
            Rest = tl(Word),
            First = hd(Word),
            NewWord = Rest ++ [First],
            {NewWord ++ "ma" ++ lists:duplicate(Index, $a), Index + 1};
        _ ->
            {Word ++ "ma" ++ lists:duplicate(Index, $a), Index + 1}
    end.