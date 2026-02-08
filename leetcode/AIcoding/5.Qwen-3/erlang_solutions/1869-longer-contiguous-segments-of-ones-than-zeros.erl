-module(solution).
-export([check_ones_segment/1]).

check_ones_segment(S) ->
    {MaxOnes, MaxZeros} = count_segments(S),
    MaxOnes > MaxZeros.

count_segments(S) ->
    count_segments(S, 0, 0, 0, 0).

count_segments([], CurrentOnes, CurrentZeros, MaxOnes, MaxZeros) ->
    {CurrentOnes, CurrentZeros};
count_segments([H | T], CurrentOnes, CurrentZeros, MaxOnes, MaxZeros) ->
    if
        H == $1 ->
            count_segments(T, CurrentOnes + 1, 0, max(MaxOnes, CurrentOnes + 1), MaxZeros);
        true ->
            count_segments(T, 0, CurrentZeros + 1, MaxOnes, max(MaxZeros, CurrentZeros + 1))
    end.