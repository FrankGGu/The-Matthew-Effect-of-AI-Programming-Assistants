-module(solution).
-export([countSubstrings/1]).

countSubstrings(S) ->
    Len = byte_size(S),
    count_all_palindromes(S, Len, 0, 0).

count_all_palindromes(S, Len, I, Acc) when I < Len ->
    Acc1 = Acc + expand_around_center(S, Len, I, I, 0),
    Acc2 = Acc1 + expand_around_center(S, Len, I, I + 1, 0),
    count_all_palindromes(S, Len, I + 1, Acc2);
count_all_palindromes(_S, _Len, _I, Acc) ->
    Acc.

expand_around_center(S, Len, L, R, Count) when L >= 0 andalso R < Len andalso binary:at(S, L) == binary:at(S, R) ->
    expand_around_center(S, Len, L - 1, R + 1, Count + 1);
expand_around_center(_S, _Len, _L, _R, Count) ->
    Count.