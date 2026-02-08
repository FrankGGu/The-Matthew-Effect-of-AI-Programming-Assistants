-module(stone_removal_game).
-export([play/1]).

play(Stones) ->
    play(Stones, 0).

play([], _Turn) ->
    0;
play([H | T], Turn) ->
    if
        Turn rem 2 == 0 ->
            % Alice's turn: remove H and add to score
            H + play(T, Turn + 1);
        true ->
            % Bob's turn: remove H and add to score
            H + play(T, Turn + 1)
    end.