-module(solution).
-export([max_score_words/3]).

max_score_words(Words, Letters, Score) ->
    LetterCounts = count_letters(Letters),
    WordCounts = [count_letters(Word) || Word <- Words],
    MaxScore = calculate_max_score(Words, WordCounts, LetterCounts, Score, 0, 0),
    MaxScore.

count_letters(Str) ->
    lists:foldl(fun(C, Acc) ->
                    maps:update_with(C, fun(V) -> V + 1 end, 1, Acc)
                end, #{}, Str).

calculate_max_score(Words, WordCounts, LetterCounts, Score, Index, CurrentScore) ->
    if
        Index >= length(Words) ->
            CurrentScore;
        true ->
            WordCount = lists:nth(Index + 1, WordCounts),
            case can_form_word(WordCount, LetterCounts) of
                true ->
                    NewLetterCounts = subtract_counts(LetterCounts, WordCount),
                    WordScore = calculate_word_score(lists:nth(Index + 1, Words), Score),
                    ScoreWithWord = calculate_max_score(Words, WordCounts, NewLetterCounts, Score, Index + 1, CurrentScore + WordScore),
                    ScoreWithoutWord = calculate_max_score(Words, WordCounts, LetterCounts, Score, Index + 1, CurrentScore),
                    max(ScoreWithWord, ScoreWithoutWord);
                false ->
                    calculate_max_score(Words, WordCounts, LetterCounts, Score, Index + 1, CurrentScore)
            end
    end.

can_form_word(WordCount, LetterCounts) ->
    maps:fold(fun(Char, Count, Acc) ->
                  case maps:get(Char, LetterCounts, 0) >= Count of
                      true -> Acc;
                      false -> false
                  end
              end, true, WordCount).

subtract_counts(LetterCounts, WordCount) ->
    maps:fold(fun(Char, Count, Acc) ->
                  case maps:get(Char, Acc, 0) - Count of
                      NewCount when NewCount >= 0 -> maps:put(Char, NewCount, Acc);
                      _ -> Acc
                  end
              end, LetterCounts, WordCount).

calculate_word_score(Word, Score) ->
    lists:sum([lists:nth(C - $a + 1, Score) || C <- Word]).