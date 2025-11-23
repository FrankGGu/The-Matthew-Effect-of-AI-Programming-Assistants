-module(stone_game_iii).
-export([stone_game_iii/1]).

stone_game_iii(steins) ->
    N = length(steins),
    DP = array:new(N, {default, 0}),
    DP2 = array:new(N, {default, 0}),
    solve(steins, N - 1, DP, DP2).

solve(_, -1, _, _) ->
    0;
solve(Steins, I, DP, DP2) ->
    if
        I == 0 ->
            array:get(I, Steins);
        true ->
            Res = array:get(I, Steins),
            if
                I - 1 >= 0 ->
                    Res1 = Res - array:get(I - 1, Steins),
                    Res1 = Res1 + (if I - 2 >= 0 -> array:get(I - 2, DP) else 0 end),
                    Res = max(Res, Res1)
                end,
            if
                I - 2 >= 0 ->
                    Res2 = Res - array:get(I - 1, Steins) - array:get(I - 2, Steins),
                    Res2 = Res2 + (if I - 3 >= 0 -> array:get(I - 3, DP) else 0 end),
                    Res = max(Res, Res2)
                end,
            array:set(I, Res, DP),
            Res
    end.