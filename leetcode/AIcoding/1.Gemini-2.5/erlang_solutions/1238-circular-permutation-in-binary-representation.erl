-module(solution).
-export([circular_permutation/2]).

circular_permutation(N, Start) ->
    Size = 1 bsl N,
    GrayCodeList = [I bxor (I bsr 1) || I <- lists:seq(0, Size - 1)],

    K = find_start_index(GrayCodeList, Start, 0),

    {Head, Tail} = lists:split(K, GrayCodeList),

    Tail ++ Head.

find_start_index([H|_T], Start, Index) when H == Start ->
    Index;
find_start_index([_H|T], Start, Index) ->
    find_start_index(T, Start, Index + 1).