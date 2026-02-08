-module(solution).
-export([minimum_time/2]).

minimum_time(Word, Moves) ->
    Length = length(Word),
    calculate_time(Word, Moves, Length, 0).

calculate_time(Word, Moves, Length, Time) ->
    case Moves of
        [] -> Time;
        [H|T] ->
            NewWord = revert(Word, H),
            NewTime = Time + 1,
            calculate_time(NewWord, T, Length, NewTime)
    end.

revert(Word, Index) ->
    case Index of
        0 -> Word;
        _ -> lists:sublist(Word, 1, Index) ++ lists:nthtail(Index, Word)
    end.