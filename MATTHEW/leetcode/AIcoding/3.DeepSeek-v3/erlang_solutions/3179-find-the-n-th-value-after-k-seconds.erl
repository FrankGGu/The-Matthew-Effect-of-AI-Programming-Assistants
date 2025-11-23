-module(solution).
-export([value_after_k_seconds/2]).

value_after_k_seconds(N, K) ->
    Mod = 1000000007,
    DP = lists:duplicate(N, 1),
    value_after_k_seconds_helper(DP, K, Mod).

value_after_k_seconds_helper(DP, 0, _Mod) ->
    lists:last(DP);
value_after_k_seconds_helper(DP, K, Mod) ->
    NewDP = compute_new_dp(DP, Mod),
    value_after_k_seconds_helper(NewDP, K - 1, Mod).

compute_new_dp(DP, Mod) ->
    compute_new_dp(DP, 0, [], Mod).

compute_new_dp([], _Sum, Acc, _Mod) ->
    lists:reverse(Acc);
compute_new_dp([H | T], Sum, Acc, Mod) ->
    NewSum = (Sum + H) rem Mod,
    compute_new_dp(T, NewSum, [NewSum | Acc], Mod).