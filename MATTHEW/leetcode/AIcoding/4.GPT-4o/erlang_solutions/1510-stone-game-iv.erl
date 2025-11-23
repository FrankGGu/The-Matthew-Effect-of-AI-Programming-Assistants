-module(solution).
-export([stone_game_iv/1]).

stone_game_iv(N) ->
    DP = lists:duplicate(N + 1, false),
    DP = fill_dp(DP, N, 1),
    DP(N).

fill_dp(DP, N, I) when I * I =< N ->
    NewDP = lists:sublist(DP, 1, I * I - 1) ++ [not lists:nth(I * I, DP)] ++ lists:sublist(DP, I * I + 1, N - I * I),
    fill_dp(NewDP, N, I + 1);
fill_dp(DP, _, _) ->
    DP.