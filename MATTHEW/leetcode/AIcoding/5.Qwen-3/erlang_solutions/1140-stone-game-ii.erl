-module(stone_game_ii).
-export([stoneGameII/1]).

stoneGameII(Piles) ->
    N = length(Piles),
    Max = 2 * N,
    DP = array:new(N, {default, 0}),
    Sum = lists:sum(Piles),
    stoneGameII(Piles, N, 1, DP, Sum).

stoneGameII(_, 0, _, DP, _) ->
    array:get(0, DP);
stoneGameII(Piles, I, M, DP, Total) ->
    if
        I == 0 ->
            0;
        true ->
            Key = I - 1,
            Current = array:get(Key, DP),
            if
                Current /= 0 ->
                    Current;
                true ->
                    MaxTake = min(2 * M, I),
                    Best = 0,
                    Take = 1,
                    stoneGameIILoop(Piles, I, M, Take, MaxTake, Best, DP, Total),
                    array:set(Key, Best, DP)
            end
    end.

stoneGameIILoop(_, _, _, Take, MaxTake, Best, DP, Total) when Take > MaxTake ->
    Best;
stoneGameIILoop(Piles, I, M, Take, MaxTake, Best, DP, Total) ->
    NextI = I - Take,
    NextM = max(M, Take),
    NextBest = stoneGameII(Piles, NextI, NextM, DP, Total),
    Current = lists:sublist(Piles, I - Take + 1, Take),
    CurrentSum = lists:sum(Current),
    NewBest = max(Best, Total - CurrentSum - NextBest),
    stoneGameIILoop(Piles, I, M, Take + 1, MaxTake, NewBest, DP, Total).