-module(text_justification).
-export([full_justify/2]).

full_justify([], _) -> [];
full_justify([Word], MaxWidth) ->
    [string:copies($ , MaxWidth - length(Word)) ++ Word];
full_justify([Word | Rest], MaxWidth) ->
    case length(Word) + 1 + length(hd(Rest)) of
        Len when Len =< MaxWidth ->
            Line = [Word, " ", hd(Rest)],
            full_justify(tl(Rest), MaxWidth, Line);
        _ ->
            [Word] ++ full_justify(Rest, MaxWidth)
    end.

full_justify([], _, Line) ->
    [pad_line(Line, 0)];
full_justify([Word | Rest], MaxWidth, CurrentLine) ->
    case length(CurrentLine) + 1 + length(Word) of
        Len when Len =< MaxWidth ->
            full_justify(Rest, MaxWidth, CurrentLine ++ [" ", Word]);
        _ ->
            [pad_line(CurrentLine, 0)] ++ full_justify([Word | Rest], MaxWidth)
    end.

pad_line([], _) -> "";
pad_line([H], Spaces) -> H ++ string:copies($ , Spaces);
pad_line(Line, Spaces) ->
    Words = lists:split(length(Line) - 1, Line),
    WordCount = length(Words),
    TotalSpaces = MaxWidth - (lists:sum([length(W) || W <- Line])),
    SpacePerGap = case WordCount of
        0 -> 0;
        _ -> TotalSpaces div WordCount
    end,
    ExtraSpaces = TotalSpaces rem WordCount,
    Padded = lists:foldl(fun({W, Gap}, Acc) ->
        Acc ++ W ++ string:copies($ , SpacePerGap + (if Gap < ExtraSpaces -> 1; true -> 0 end))
    end, "", lists:zip(Words, lists:seq(1, WordCount))),
    Padded.