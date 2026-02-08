-module(maximum_score_words).
-export([maxScoreWords/3]).

maxScoreWords(Words, Letters, Score) ->
    max_score_words(Words, Letters, Score, 0).

max_score_words([], _, _, Acc) ->
    Acc;
max_score_words(Words, Letters, Score, Acc) ->
    max(max_score_words(tl(Words), Letters, Score, Acc),
        case can_form_word(hd(Words), Letters) of
            true ->
                NewLetters = remove_word_letters(hd(Words), Letters),
                NewScore = Acc + word_score(hd(Words), Score),
                max_score_words(tl(Words), NewLetters, Score, NewScore);
            false ->
                Acc
        end).

can_form_word(Word, Letters) ->
    can_form_word(Word, Letters, []).

can_form_word([], Letters, _) ->
    true;
can_form_word([H|T], Letters, Used) ->
    case lists:member(H, Letters) of
        true ->
            case lists:member(H, Used) of
                true ->
                    CountInLetters = lists:foldl(fun(X, Acc2) -> if X == H -> Acc2 + 1; true -> Acc2 end end, 0, Letters),
                    CountInUsed = lists:foldl(fun(X, Acc2) -> if X == H -> Acc2 + 1; true -> Acc2 end end, 0, Used),
                    if CountInLetters > CountInUsed then
                        can_form_word(T, Letters, [H|Used])
                    else
                        false
                    end;
                false ->
                    can_form_word(T, Letters, [H|Used])
            end;
        false ->
            false
    end.

remove_word_letters(Word, Letters) ->
    remove_word_letters(Word, Letters, []).

remove_word_letters([], Letters, Acc) ->
    Letters;
remove_word_letters([H|T], Letters, Acc) ->
    remove_word_letters(T, lists:delete(H, Letters), Acc).

word_score(Word, Score) ->
    lists:sum([lists:nth(H - $a + 1, Score) || H <- Word]).