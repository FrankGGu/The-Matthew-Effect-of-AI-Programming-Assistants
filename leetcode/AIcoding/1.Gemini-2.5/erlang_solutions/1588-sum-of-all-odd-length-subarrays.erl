-module(solution).
-export([sum_odd_length_subarrays/1]).

-spec sum_odd_length_subarrays(Arr :: [integer()]) -> integer().
sum_odd_length_subarrays(Arr) ->
    N = length(Arr),
    sum_odd_length_subarrays_recursive(Arr, N, 0, 0).

sum_odd_length_subarrays_recursive([], _N, _Index, Acc) ->
    Acc;
sum_odd_length_subarrays_recursive([H|T], N, Index, Acc) ->
    LeftCount = Index + 1,
    RightCount = N - Index,
    NumOddSubarrays = (LeftCount * RightCount + 1) div 2,
    NewAcc = Acc + H * NumOddSubarrays,
    sum_odd_length_subarrays_recursive(T, N, Index + 1, NewAcc).