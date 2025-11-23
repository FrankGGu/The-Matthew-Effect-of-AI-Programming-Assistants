-module(solution).
-export([count_substrings/2]).

count_substrings(S, K) ->
    N = length(S),
    count_substrings_helper(S, K, N, 0).

count_substrings_helper(_, _, 0, Count) ->
    Count;
count_substrings_helper(S, K, N, Count) ->
    PrefixSum = lists:foldl(fun (C, Acc) -> 
        case C of 
            $a -> Acc + 1; 
            _   -> Acc 
        end 
    end, 0, lists:sublist(S, N)),
    if 
        PrefixSum >= K -> 
            count_substrings_helper(S, K, N - 1, Count + 1);
        true -> 
            count_substrings_helper(S, K, N - 1, Count)
    end.