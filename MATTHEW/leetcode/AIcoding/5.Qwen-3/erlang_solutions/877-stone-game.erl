-module(stone_game).
-export([stone_game/1]).

stone_game(Piles) ->
    N = length(Piles),
    DP = array:new(N, {default, 0}),
    stone_game(Piles, N, DP).

stone_game(_, 0, _) -> 0;
stone_game(Piles, N, DP) ->
    Max = array:get(N-1, Piles),
    Min = array:get(0, Piles),
    case N of
        1 -> Max;
        _ -> 
            Left = stone_game(Piles, N-1, DP) - array:get(N-1, Piles),
            Right = stone_game(Piles, N-1, DP) - array:get(0, Piles),
            array:set(N-1, max(Left, Right), DP),
            array:get(N-1, DP)
    end.