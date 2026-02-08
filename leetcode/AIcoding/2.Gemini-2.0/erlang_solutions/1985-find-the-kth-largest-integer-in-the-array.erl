-module(kth_largest_integer).
-export([kth_largest_integer/2]).

kth_largest_integer(Nums, K) ->
    SortedNums = lists:sort(fun(A, B) -> compare_integers(A, B) end, Nums),
    lists:nth(length(Nums) - K + 1, SortedNums).

compare_integers(A, B) ->
    case {string:len(A), string:len(B)} of
        {LenA, LenB} when LenA > LenB ->
            true;
        {LenA, LenB} when LenA < LenB ->
            false;
        {Len, Len} ->
            A > B
    end.