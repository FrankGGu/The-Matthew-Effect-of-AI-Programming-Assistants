-module(rearrange_spaces).
-export([reorder_words/1]).

reorder_words(Str) ->
    Words = string:tokens(Str, " "),
    WordCount = length(Words),
    if
        WordCount == 1 -> lists:flatten([hd(Words), string:copies(" ", length(Str) - length(hd(Words)))]);
        true ->
            TotalSpaces = length(Str) - lists:sum([length(W) || W <- Words]),
            SpacesBetween = TotalSpaces div (WordCount - 1),
            ExtraSpaces = TotalSpaces rem (WordCount - 1),
            Spaces = string:copies(" ", SpacesBetween),
            Result = lists:foldl(fun(W, Acc) -> Acc ++ W ++ Spaces end, "", lists:tl(Words)),
            lists:sublist(Result, length(Result) - SpacesBetween) ++ string:copies(" ", ExtraSpaces)
    end.