-module(solution).
-export([printVertically/1]).

printVertically(S) ->
    Words = string:tokens(S, " "),
    MaxLen = lists:foldl(fun(Word, Acc) -> max(Acc, string:len(Word)) end, 0, Words),

    lists:map(fun(ColIdx) ->
        build_column(ColIdx, Words)
    end, lists:seq(0, MaxLen - 1)).

build_column(ColIdx, Words) ->
    Chars = [get_char_at_col(Word, ColIdx) || Word <- Words],
    FullColumn = lists:flatten([ [Char] || Char <- Chars ]),
    string:trim(FullColumn, trailing).

get_char_at_col(Word, ColIdx) ->
    if ColIdx < string:len(Word) ->
        string:at(Word, ColIdx + 1);
    true ->
        32 % ASCII for space
    end.