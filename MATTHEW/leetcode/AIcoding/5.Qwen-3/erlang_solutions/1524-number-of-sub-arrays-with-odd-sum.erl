-module(solution).
-export([num_odd_subarrays/1]).

num_odd_subarrays(Nums) ->
    num_odd_subarrays(Nums, 0, 0, 0).

num_odd_subarrays([], _, _, Count) ->
    Count;
num_odd_subarrays([H | T], Sum, EvenCount, Count) ->
    NewSum = Sum + H,
    case NewSum rem 2 of
        0 ->
            num_odd_subarrays(T, NewSum, EvenCount + 1, Count);
        1 ->
            num_odd_subarrays(T, NewSum, EvenCount, Count + EvenCount + 1)
    end.