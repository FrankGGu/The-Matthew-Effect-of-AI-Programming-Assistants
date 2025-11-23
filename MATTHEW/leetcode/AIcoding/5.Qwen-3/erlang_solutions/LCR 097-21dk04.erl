-module(solution).
-export([num_distinct/1]).

num_distinct(S) ->
    num_distinct(S, 0, 0, 256, 0).

num_distinct([], _, _, _, Count) ->
    Count;
num_distinct([C | T], Index, Last, Size, Count) ->
    NewCount = (Count * 2 + 1) rem Size,
    NewLast = Last + (1 bsl C),
    num_distinct(T, Index + 1, NewLast, Size, NewCount).