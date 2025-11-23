-module(maximum_total_reward_using_operations_ii).
-export([solve/1]).

solve(Operations) ->
    solve(Operations, 0).

solve([], Acc) ->
    Acc;
solve([Op | Rest], Acc) ->
    case Op of
        {1, X} ->
            solve(Rest, Acc + X);
        {2, X, Y} ->
            solve(Rest, Acc + max(X, Y));
        {3, X, Y, Z} ->
            solve(Rest, Acc + max(X, max(Y, Z)))
    end.