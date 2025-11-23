-module(new_21_game).
-export([new_game/1]).

new_game(0) -> 0.5;
new_game(N) ->
    {_, Score} = lists:foldl(fun(I, {Sum, Acc}) ->
        if
            I == 1 -> {1, 1};
            true -> {Sum + Acc, Acc + Sum}
        end
    end, {0, 0}, lists:seq(1, N)),
    Score / math:pow(2, N).