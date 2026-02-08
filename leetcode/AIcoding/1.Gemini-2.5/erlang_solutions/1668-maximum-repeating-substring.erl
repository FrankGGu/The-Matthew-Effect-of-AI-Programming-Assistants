-module(solution).
-export([maxRepeating/2]).

maxRepeating(Sequence, Word) ->
    maxRepeating_helper(Sequence, Word, 0, []).

maxRepeating_helper(Sequence, Word, CurrentK, CurrentRepeatedWord) ->
    NextRepeatedWord = CurrentRepeatedWord ++ Word,
    case string:str(Sequence, NextRepeatedWord) of
        0 ->
            CurrentK;
        _ ->
            maxRepeating_helper(Sequence, Word, CurrentK + 1, NextRepeatedWord)
    end.