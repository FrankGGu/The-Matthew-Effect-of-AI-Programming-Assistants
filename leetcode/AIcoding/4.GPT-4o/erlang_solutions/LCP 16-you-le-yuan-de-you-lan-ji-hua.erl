-module(solution).
-export([get_plan/3]).

get_plan(N, K, A) ->
    get_plan_helper(N, K, A, 0, []).

get_plan_helper(N, K, A, Current, Visited) when Current == N -> 
    lists:reverse(Visited);
get_plan_helper(N, K, A, Current, Visited) ->
    Next = (Current + K) rem N,
    get_plan_helper(N, K, A, Next, [A(Current) | Visited]).