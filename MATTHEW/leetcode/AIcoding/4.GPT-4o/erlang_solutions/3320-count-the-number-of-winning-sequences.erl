-module(solution).
-export([countWinningSequences/1]).

countWinningSequences(N) ->
    case N rem 2 of
        0 -> 0;
        _ -> count_winning_sequences(N, 0, 0)
    end.

count_winning_sequences(0, A, B) -> A;
count_winning_sequences(N, A, B) ->
    count_winning_sequences(N - 1, B, A + B + 1).