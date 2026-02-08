-module(text_justification).
-export([fullJustify/2]).

fullJustify(Words, MaxWidth) ->
    fullJustify(Words, MaxWidth, [], []).

fullJustify([], _MaxWidth, CurrentLine, Acc) ->
    ReverseLine = lists:reverse(CurrentLine),
    JustifiedLine = string:join(ReverseLine, " "),
    PaddedLine = padRight(JustifiedLine, " ", length(JustifiedLine), MaxWidth),
    lists:reverse([PaddedLine | Acc]);
fullJustify([Word | RestWords], MaxWidth, CurrentLine, Acc) ->
    LineLength = lists:sum([length(W) || W <- CurrentLine]) + length(CurrentLine),
    WordLength = length(Word),
    if LineLength + WordLength + 1 =< MaxWidth ->
        fullJustify(RestWords, MaxWidth, [Word | CurrentLine], Acc);
    true ->
        ReverseLine = lists:reverse(CurrentLine),
        NumWords = length(ReverseLine),
        if NumWords =:= 1 ->
            JustifiedLine = lists:nth(1, ReverseLine),
            PaddedLine = padRight(JustifiedLine, " ", length(JustifiedLine), MaxWidth),
            fullJustify([Word | RestWords], MaxWidth, [], [PaddedLine | Acc]);
        true ->
            TotalWordLength = lists:sum([length(W) || W <- ReverseLine]),
            NumSpaces = MaxWidth - TotalWordLength,
            BaseSpaces = NumSpaces div (NumWords - 1),
            ExtraSpaces = NumSpaces rem (NumWords - 1),
            JustifiedLine = justifyLine(ReverseLine, BaseSpaces, ExtraSpaces),
            fullJustify([Word | RestWords], MaxWidth, [], [JustifiedLine | Acc])
        end
    end.

justifyLine([Word], _BaseSpaces, _ExtraSpaces) ->
    Word;
justifyLine([Word | RestWords], BaseSpaces, ExtraSpaces) ->
    Space = string:copies(" ", BaseSpaces),
    if ExtraSpaces > 0 ->
        justifyLine(RestWords, BaseSpaces, ExtraSpaces - 1) ++ Space ++ Word ++ " ";
    true ->
        justifyLine(RestWords, BaseSpaces, ExtraSpaces) ++ Space ++ Word
    end.

padRight(String, Char, CurrentLength, MaxLength) ->
    if CurrentLength >= MaxLength ->
        String;
    true ->
        padRight(String ++ Char, Char, CurrentLength + 1, MaxLength)
    end.