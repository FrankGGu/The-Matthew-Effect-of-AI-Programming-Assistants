-module(solution).
-export([fullJustify/2]).

fullJustify(Words, MaxWidth) ->
    justify_lines(Words, MaxWidth, []).

justify_lines([], _MaxWidth, Acc) ->
    lists:reverse(Acc);
justify_lines(Words, MaxWidth, Acc) ->
    {LineWords, RemainingWords} = get_line_words(Words, MaxWidth),
    IsLastLine = (RemainingWords == []),
    Line = format_line(LineWords, MaxWidth, IsLastLine),
    justify_lines(RemainingWords, MaxWidth, [Line | Acc]).

get_line_words(Words, MaxWidth) ->
    get_line_words(Words, MaxWidth, [], 0, 0).

get_line_words([], _MaxWidth, CurrentWords, _CurrentLengthWithSpaces, _CurrentNumWords) ->
    {lists:reverse(CurrentWords), []};
get_line_words([Word | Rest], MaxWidth, CurrentWords, CurrentLengthWithSpaces, CurrentNumWords) ->
    WordLength = length(Word),
    PotentialLengthWithSpaces = CurrentLengthWithSpaces + WordLength + (if CurrentNumWords > 0 -> 1; true -> 0 end),
    if
        PotentialLengthWithSpaces =< MaxWidth ->
            get_line_words(Rest, MaxWidth, [Word | CurrentWords], PotentialLengthWithSpaces, CurrentNumWords + 1);
        true ->
            {lists:reverse(CurrentWords), [Word | Rest]}
    end.

format_line(LineWords, MaxWidth, IsLastLine) ->
    WordLengths = [length(W) || W <- LineWords],
    TotalWordLength = lists:sum(WordLengths),
    NumWords = length(LineWords),

    if
        IsLastLine ->
            format_last_line(LineWords, MaxWidth, TotalWordLength);
        NumWords == 1 ->
            format_single_word_line(LineWords, MaxWidth, TotalWordLength);
        true ->
            format_normal_line(LineWords, MaxWidth, TotalWordLength, NumWords)
    end.

format_last_line(LineWords, MaxWidth, TotalWordLength) ->
    Joined = string:join(LineWords, " "),
    SpacesNeeded = MaxWidth - length(Joined),
    Joined ++ string:chars($ , SpacesNeeded).

format_single_word_line([Word], MaxWidth, TotalWordLength) ->
    SpacesNeeded = MaxWidth - TotalWordLength,
    Word ++ string:chars($ , SpacesNeeded).

format_normal_line(LineWords, MaxWidth, TotalWordLength, NumWords) ->
    NumGaps = NumWords - 1,
    TotalSpaces = MaxWidth - TotalWordLength,
    BaseSpaces = TotalSpaces div NumGaps,
    ExtraSpaces = TotalSpaces rem NumGaps,

    distribute_spaces(LineWords, BaseSpaces, ExtraSpaces).

distribute_spaces([Word], _BaseSpaces, _ExtraSpaces) ->
    Word;
distribute_spaces([Word | Rest], BaseSpaces, ExtraSpaces) ->
    CurrentGapSpaces = BaseSpaces + (if ExtraSpaces > 0 -> 1; true -> 0 end),
    SpaceString = string:chars($ , CurrentGapSpaces),
    NewExtraSpaces = if ExtraSpaces > 0 -> ExtraSpaces - 1; true -> 0 end,
    Word ++ SpaceString ++ distribute_spaces(Rest, BaseSpaces, NewExtraSpaces).