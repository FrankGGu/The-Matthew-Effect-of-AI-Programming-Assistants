-module(solution).
-export([min_operations/1]).

min_operations(A) ->
    min_operations(A, 0).

min_operations([], _) ->
    0;
min_operations([H | T], Acc) ->
    if
        H == 0 ->
            min_operations(T, Acc);
        true ->
            N = H rem 2,
            NewAcc = Acc + N,
            min_operations([H - N | T], NewAcc)
    end.