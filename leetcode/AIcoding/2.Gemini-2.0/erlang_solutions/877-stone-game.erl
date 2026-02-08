-module(stone_game).
-export([stone_game/1]).

stone_game(Piles) ->
    length(Piles) rem 2 == 0.