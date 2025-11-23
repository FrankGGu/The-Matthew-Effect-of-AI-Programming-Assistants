-module(solution).
-export([count_subarrays/2]).

count_subarrays(Numbers, K) ->
    count_subarrays(Numbers, K, 0, 0).

count_subarrays([], _, Count, _) -> Count;
count_subarrays([H | T], K, Count, Current) ->
    NewCurrent = Current + H,
    if 
        NewCurrent rem K =:= 0 -> 
            count_subarrays(T, K, Count + 1, NewCurrent);
        true -> 
            count_subarrays(T, K, Count, NewCurrent)
    end.