-module(solution).
-export([countSubstrings/1]).

countSubstrings(S) ->
    BinS = list_to_binary(S),
    N = byte_size(BinS),
    count_palindromes(BinS, N, 0, 0).

count_palindromes(_BinS, _N, I, Acc) when I >= _N ->
    Acc;
count_palindromes(BinS, N, I, Acc) ->
    Acc1 = expand_around_center(BinS, I, I, N, Acc),
    Acc2 = expand_around_center(BinS, I, I + 1, N, Acc1),
    count_palindromes(BinS, N, I + 1, Acc2).

expand_around_center(BinS, L, R, N, CurrentCount) ->
    if
        L < 0 orelse R >= N ->
            CurrentCount;
        binary:at(BinS, L) == binary:at(BinS, R) ->
            expand_around_center(BinS, L - 1, R + 1, N, CurrentCount + 1);
        true ->
            CurrentCount
    end.