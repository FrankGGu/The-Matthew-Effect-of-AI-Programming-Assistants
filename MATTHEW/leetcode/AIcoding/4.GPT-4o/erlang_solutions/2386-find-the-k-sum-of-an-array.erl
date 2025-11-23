-module(solution).
-export([k_sum/3]).

k_sum(Array, K, Target) ->
    SortedArray = lists:sort(Array),
    k_sum_helper(SortedArray, K, Target).

k_sum_helper(Array, K, Target) when K == 2 ->
    two_sum(Array, Target);
k_sum_helper(Array, K, Target) ->
    lists:flatmap(fun(X) -> 
        k_sum_helper(tl(Array), K - 1, Target - X) 
    end, Array).

two_sum(Array, Target) ->
    two_sum_helper(Array, Target, []).

two_sum_helper([], _, _) ->
    [];
two_sum_helper([H | T], Target, Seen) ->
    case lists:member(Target - H, Seen) of
        true -> [[H, Target - H] | two_sum_helper(T, Target, [H | Seen])];
        false -> two_sum_helper(T, Target, [H | Seen])
    end.