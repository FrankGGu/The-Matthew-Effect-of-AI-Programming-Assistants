-module(solution).
-export([maxScoreWords/3]).

maxScoreWords(Words, Letters, Score) ->
    max_score(Words, Letters, Score, 0).

max_score([], _, _, CurrentMax) ->
    CurrentMax;
max_score([Word | Rest], Letters, Score, CurrentMax) ->
    case can_form(Word, Letters) of
        true ->
            NewScore = CurrentMax + word_score(Word, Score),
            max_score(Rest, Letters -- Word, Score, max(NewScore, CurrentMax));
        false ->
            max_score(Rest, Letters, Score, CurrentMax)
    end.

can_form(Word, Letters) ->
    WordChars = string:to_list(Word),
    LetterCounts = lists:foldl(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, 1, Acc) end, #{}, WordChars),
    lists:all(fun({C, Count}) -> maps:get(C, LetterCounts, 0) >= Count end, maps:to_list(LetterCounts)).

word_score(Word, Score) ->
    WordChars = string:to_list(Word),
    lists:sum([lists:nth(C + 1, Score) || C <- lists:map(fun(C) -> (C - $a) end, WordChars)]).