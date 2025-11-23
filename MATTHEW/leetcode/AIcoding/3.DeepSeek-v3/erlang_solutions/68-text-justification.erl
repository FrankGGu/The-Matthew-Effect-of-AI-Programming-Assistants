-module(text_justification).
-export([fullJustify/2]).

fullJustify(Words, MaxWidth) ->
    fullJustify(Words, MaxWidth, [], []).

fullJustify([], _, Line, Result) ->
    Result ++ [formatLastLine(Line, MaxWidth)];
fullJustify([Word | Rest], MaxWidth, Line, Result) ->
    case canAddWord(Word, Line, MaxWidth) of
        true ->
            fullJustify(Rest, MaxWidth, Line ++ [Word], Result);
        false ->
            JustifiedLine = formatLine(Line, MaxWidth),
            fullJustify([Word | Rest], MaxWidth, [], Result ++ [JustifiedLine])
    end.

canAddWord(Word, Line, MaxWidth) ->
    LineLength = lists:sum([length(W) || W <- Line]),
    Spaces = length(Line),
    LineLength + length(Word) + Spaces =< MaxWidth.

formatLine([Word], MaxWidth) ->
    Word ++ string:chars($ , MaxWidth - length(Word));
formatLine(Words, MaxWidth) ->
    TotalLength = lists:sum([length(W) || W <- Words]),
    TotalSpaces = MaxWidth - TotalLength,
    Gaps = length(Words) - 1,
    BaseSpaces = TotalSpaces div Gaps,
    ExtraSpaces = TotalSpaces rem Gaps,
    formatLine(Words, BaseSpaces, ExtraSpaces, "").

formatLine([Word], _, _, Acc) ->
    Acc ++ Word;
formatLine([Word | Rest], BaseSpaces, ExtraSpaces, Acc) ->
    Spaces = BaseSpaces + (if ExtraSpaces > 0 -> 1; true -> 0 end),
    NewAcc = Acc ++ Word ++ string:chars($ , Spaces),
    formatLine(Rest, BaseSpaces, ExtraSpaces - 1, NewAcc).

formatLastLine(Words, MaxWidth) ->
    LastLine = string:join(Words, " "),
    LastLine ++ string:chars($ , MaxWidth - length(LastLine)).