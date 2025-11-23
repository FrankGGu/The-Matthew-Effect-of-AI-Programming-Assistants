-module(solution).
-export([num_of_split/1]).

num_of_split(A) ->
    N = length(A),
    Count = 0,
    do_split(A, 0, N-1, Count).

do_split(_, L, R, Count) when L >= R ->
    Count;
do_split(A, L, R, Count) ->
    Mid = (L + R) div 2,
    Left = lists:sublist(A, L+1, Mid - L),
    Right = lists:sublist(A, Mid+1, R - Mid),
    LeftSum = lists:sum(Left),
    RightSum = lists:sum(Right),
    if
        LeftSum == RightSum ->
            NewCount = Count + 1,
            do_split(A, L, Mid-1, NewCount) + do_split(A, Mid+1, R, NewCount);
        true ->
            do_split(A, L, Mid-1, Count) + do_split(A, Mid+1, R, Count)
    end.