-module(new_21_game).
-export([new_21_game/3]).

new_21_game(n, k, max_pts) ->
    new_21_game_helper(n, k, max_pts, 0.0).

new_21_game_helper(N, K, MaxPts, Probability) ->
    if K =< 0,
        if N >= 0,
            1.0,
            0.0
        else
            0.0
    else
        DP = lists:duplicate(K + MaxPts, 0.0),
        DP_new = lists:nth(1, lists:map(fun(I) ->
                                                if I =< N,
                                                    1.0,
                                                    0.0
                                                end
                                        end, lists:seq(K, N))),
        DP_init = lists:sublist(DP, 1, K - 1) ++ [DP_new | lists:sublist(DP, K, MaxPts)],
        new_21_game_dp(N, K, MaxPts, DP_init, 0.0).

new_21_game_dp(N, K, MaxPts, DP, Probability) ->
    if K =:= 0,
        lists:sum(lists:sublist(DP, 1, N + 1)),

    else
        Win = lists:sum(lists:sublist(DP, 1, K)),
        DP_new = Win / MaxPts,
        DP_updated = [DP_new | lists:sublist(DP, 1, K + MaxPts - 1)],
        new_21_game_dp(N, K - 1, MaxPts, DP_updated, Probability).