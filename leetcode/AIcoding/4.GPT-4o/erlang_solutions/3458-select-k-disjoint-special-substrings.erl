-module(solution).
-export([select_k_disjoint_special_substrings/2]).

select_k_disjoint_special_substrings(S, K) ->
    N = length(S),
    select_k_disjoint_special_substrings_helper(S, K, N, 0).

select_k_disjoint_special_substrings_helper(S, K, N, Count) when K == 0 -> 
    Count;
select_k_disjoint_special_substrings_helper(S, K, N, Count) when K > 0 ->
    lists:foldl(fun(X, Acc) ->
        case is_special(X, S) of
            true -> select_k_disjoint_special_substrings_helper(S, K - 1, N, Count + 1);
            false -> Acc
        end
    end, Count, lists:seq(1, N).

is_special(X, S) ->
    % Implement logic to check if X is a special substring in S
    true.