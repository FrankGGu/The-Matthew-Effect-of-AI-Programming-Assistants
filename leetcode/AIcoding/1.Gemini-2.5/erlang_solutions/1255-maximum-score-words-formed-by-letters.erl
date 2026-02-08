-module(solution).
-export([maxScoreWords/3]).

letters_to_freq_tuple(Letters) ->
    lists:foldl(
        fun(Char, FreqTuple) ->
            Idx = Char - $a,
            CurrentCount = element(Idx + 1, FreqTuple),
            setelement(Idx + 1, FreqTuple, CurrentCount + 1)
        end,
        list_to_tuple(lists:duplicate(26, 0)),
        Letters
    ).

score_to_tuple(ScoresList) ->
    list_to_tuple(ScoresList).

check_and_form(Word, CurrentLettersFreq, LetterScores) ->
    WordChars = binary_to_list(Word),
    lists:foldl(
        fun(Char, {CanFormAcc, ScoreAcc, FreqAcc}) ->
            if not CanFormAcc ->
                {false, 0, FreqAcc};
            else
                Idx = Char - $a,
                AvailableCount = element(Idx + 1, FreqAcc),
                LetterScore = element(Idx + 1, LetterScores),
                if AvailableCount > 0 ->
                    NewFreq = setelement(Idx + 1, FreqAcc, AvailableCount - 1),
                    {true, ScoreAcc + LetterScore, NewFreq};
                else
                    {false, 0, FreqAcc}
                end
            end
        end,
        {true, 0, CurrentLettersFreq},
        WordChars
    ).

solve(Words, CurrentLettersFreq, LetterScores, WordIndex, Memo) ->
    case maps:find({WordIndex, CurrentLettersFreq}, Memo) of
        {ok, Score} ->
            {Score, Memo};
        _ ->
            if WordIndex >= length(Words) ->
                {0, Memo};
            else
                {ScoreWithout, Memo1} = solve(Words, CurrentLettersFreq, LetterScores, WordIndex + 1, Memo),

                Word = lists:nth(WordIndex + 1, Words),
                {CanForm, WordScore, NewLettersFreq} = check_and_form(Word, CurrentLettersFreq, LetterScores),

                ScoreWith =
                    if CanForm ->
                        {ScoreWithRec, Memo2} = solve(Words, NewLettersFreq, LetterScores, WordIndex + 1, Memo1),
                        WordScore + ScoreWithRec;
                    else
                        -1
                    end,

                MaxScore = lists:max([ScoreWithout, ScoreWith]),
                NewMemo = maps:put({WordIndex, CurrentLettersFreq}, MaxScore, Memo1),
                {MaxScore, NewMemo}
            end
    end.

maxScoreWords(Words, Letters, Score) ->
    InitialLettersFreq = letters_to_freq_tuple(Letters),
    LetterScoresTuple = score_to_tuple(Score),

    {MaxScore, _FinalMemo} = solve(Words, InitialLettersFreq, LetterScoresTuple, 0, #{}),
    MaxScore.