-module(solution).
-export([new21_game/3]).

new21_game(N, K, W) ->
    if
        K =:= 0 -> 1.0;
        true ->
            DP = array:new([{size, N + W + 1}, {default, 0.0}]),
            DP1 = array:set(0, 1.0, DP),
            DP2 = calc_dp(1, N + W, K, W, DP1),
            sum_prob(N, K, W, DP2) / sum_prob(K + W - 1, K, W, DP2)
    end.

calc_dp(I, Max, K, W, DP) when I =< Max ->
    Val = case I - 1 >= 0 of
              true -> array:get(I - 1, DP);
              false -> 0.0
          end + case I - 1 >= K of
                    true -> -array:get(I - 1 - W, DP);
                    false -> 0.0
                end,
    NewDP = array:set(I, Val, DP),
    calc_dp(I + 1, Max, K, W, NewDP);
calc_dp(_, _, _, _, DP) -> DP.

sum_prob(I, K, W, DP) when I >= K ->
    array:get(I, DP) + sum_prob(I - 1, K, W, DP);
sum_prob(_, _, _, _) -> 0.0.