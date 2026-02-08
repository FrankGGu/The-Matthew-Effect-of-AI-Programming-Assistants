-module(solution).
-export([sum_of_variable_length_subarrays/1]).

sum_of_variable_length_subarrays(List) ->
    sum_subarrays(List, 0, 1).

sum_subarrays([], Acc, _) -> 
    Acc;
sum_subarrays(List, Acc, K) ->
    case lists:split(K, List) of
        {Subarray, Rest} ->
            NewAcc = Acc + lists:sum(Subarray),
            sum_subarrays(Rest, NewAcc, K + 1)
    end.