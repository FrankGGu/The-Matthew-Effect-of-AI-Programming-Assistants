-module(stone_game_viii).
-export([stoneGameVIII/1]).

stoneGameVIII(Stones) ->
    N = length(Stones),
    {_, Max} = lists:foldl(fun(I, {Acc, Max}) ->
        Current = Acc + lists:nth(I, Stones),
        {Current, max(Max, Current)}
    end, {0, 0}, lists:seq(1, N)),
    Max.