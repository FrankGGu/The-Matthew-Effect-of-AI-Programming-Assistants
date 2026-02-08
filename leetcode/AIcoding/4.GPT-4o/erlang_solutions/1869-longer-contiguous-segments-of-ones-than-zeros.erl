-module(solution).
-export([check_zero_on/1]).

check_zero_on(List) ->
    count_segments(List, 0, 0, 0).

count_segments([], Ones, Zeros, _) ->
    Ones > Zeros;
count_segments([H | T], Ones, Zeros, 1) when H =:= 0 ->
    count_segments(T, Ones, Zeros + 1, 0);
count_segments([H | T], Ones, Zeros, 0) when H =:= 1 ->
    count_segments(T, Ones + 1, Zeros, 1);
count_segments([H | T], Ones, Zeros, State) ->
    count_segments(T, Ones, Zeros, State).