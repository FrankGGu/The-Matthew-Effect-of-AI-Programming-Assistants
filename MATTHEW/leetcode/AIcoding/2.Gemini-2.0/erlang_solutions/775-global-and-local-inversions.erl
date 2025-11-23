-module(global_and_local_inversions).
-export([is_ideal_permutation/1]).

is_ideal_permutation(A) ->
    N = length(A),
    is_ideal_permutation(A, N, 0, 0).

is_ideal_permutation(A, N, Global, Local) ->
    case N of
        0 ->
            Global == Local;
        _ ->
            [H | T] = A,
            NewGlobal = Global + count_inversions(H, T),
            NewLocal = case length(T) > 0 andalso H > hd(T) of
                           true -> Local + 1;
                           false -> Local
                       end,
            is_ideal_permutation(T, N - 1, NewGlobal, NewLocal)
    end.

count_inversions(H, T) ->
    count_inversions(H, T, 0).

count_inversions(_, [], Count) ->
    Count;
count_inversions(H, [X | Rest], Count) ->
    NewCount = case H > X of
                   true -> Count + 1;
                   false -> Count
               end,
    count_inversions(H, Rest, NewCount).