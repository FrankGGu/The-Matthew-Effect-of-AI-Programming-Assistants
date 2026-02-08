-module(solution).
-export([consecutive_numbers_sum/1]).

consecutive_numbers_sum(N) ->
    consecutive_numbers_sum(N, 1, 0).

consecutive_numbers_sum(N, Start, Count) when Start > N ->
    Count;
consecutive_numbers_sum(N, Start, Count) ->
    Sum = (Start + (Start + Count)) * (Count + 1) div 2,
    if
        Sum == N ->
            consecutive_numbers_sum(N, Start + 1, Count + 1);
        Sum < N ->
            consecutive_numbers_sum(N, Start, Count + 1);
        true ->
            consecutive_numbers_sum(N, Start + 1, Count)
    end.