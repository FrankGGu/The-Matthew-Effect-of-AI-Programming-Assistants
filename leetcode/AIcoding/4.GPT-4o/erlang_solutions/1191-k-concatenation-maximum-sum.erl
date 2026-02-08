-module(solution).
-export([k_concatenation_max_sum/2]).

k_concatenation_max_sum(A, K) ->
    N = length(A),
    TotalSum = lists:sum(A),
    MaxSubArraySum = max_sub_array_sum(A),
    case K of
        1 -> MaxSubArraySum;
        _ when TotalSum > 0 -> max(MaxSubArraySum, MaxSubArraySum + TotalSum * (K - 1));
        _ -> MaxSubArraySum
    end rem 1000000007.

max_sub_array_sum([]) -> 0;
max_sub_array_sum([H|T]) ->
    max_sub_array_sum(T, H, H).

max_sub_array_sum([], _, MaxSoFar) -> MaxSoFar;
max_sub_array_sum([H|T], CurrentMax, MaxSoFar) ->
    NewCurrentMax = max(H, CurrentMax + H),
    max_sub_array_sum(T, NewCurrentMax, max(MaxSoFar, NewCurrentMax)).