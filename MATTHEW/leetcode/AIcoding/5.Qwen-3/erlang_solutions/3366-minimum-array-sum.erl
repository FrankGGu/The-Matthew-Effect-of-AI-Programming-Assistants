-module(minimum_array_sum).
-export([minimizeSum/2]).

minimizeSum(A, k) ->
    lists:sort(A),
    minimizeSumHelper(A, k, 0).

minimizeSumHelper([], _, Acc) ->
    Acc;
minimizeSumHelper([H|T], K, Acc) when K > 0 ->
    NewH = H - 1,
    minimizeSumHelper([NewH | T], K - 1, Acc + NewH);
minimizeSumHelper([H|T], K, Acc) ->
    minimizeSumHelper(T, K, Acc + H).