-module(solution).
-export([numSubarrayBoundedMax/3]).

numSubarrayBoundedMax(Nums, L, R) ->
    count_le(Nums, R, 0, 0) - count_le(Nums, L - 1, 0, 0).

count_le([], _Bound, AccTotal, _AccCurrent) ->
    AccTotal;
count_le([H|T], Bound, AccTotal, AccCurrent) when H =< Bound ->
    NewAccCurrent = AccCurrent + 1,
    NewAccTotal = AccTotal + NewAccCurrent,
    count_le(T, Bound, NewAccTotal, NewAccCurrent);
count_le([_H|T], Bound, AccTotal, _AccCurrent) ->
    count_le(T, Bound, AccTotal, 0).