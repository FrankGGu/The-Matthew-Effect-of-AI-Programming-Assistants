-module(solution).
-export([num_subarrays/1]).

num_subarrays(Nums) ->
    num_subarrays(Nums, 0, 0, 0, 0).

num_subarrays([], _, _, _, Acc) ->
    Acc;
num_subarrays([N | Rest], Start, End, Sum, Acc) ->
    NewSum = Sum + N,
    case NewSum of
        K when K >= 1000000000 ->
            num_subarrays(Rest, Start+1, Start+1, N, Acc);
        _ ->
            num_subarrays(Rest, Start, End+1, NewSum, Acc + (End - Start + 1))
    end.