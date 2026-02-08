-module(solution).
-export([count_winning_sequences/1]).

count_winning_sequences(Stats) ->
    count_winning_sequences(Stats, 0, 0, 0).

count_winning_sequences([], _, _, Acc) ->
    Acc;
count_winning_sequences([H | T], Index, Count, Acc) ->
    case H of
        0 -> count_winning_sequences(T, Index + 1, Count, Acc);
        _ ->
            NewCount = Count + 1,
            count_winning_sequences(T, Index + 1, NewCount, Acc)
    end.