-module(solution).
-export([stone_game/1]).

stone_game(Piles) ->
    play(Piles, 0, 0, true).

play([], Alice, Bob, _) ->
    Alice > Bob;
play([H | T], Alice, Bob, true) ->
    play(T, Alice + H, Bob, false) orelse play(lists:reverse(T), Alice + H, Bob, false);
play([H | T], Alice, Bob, false) ->
    play(T, Alice, Bob + H, true) andalso play(lists:reverse(T), Alice, Bob + H, true).