-module(stone_game_vii).
-export([play/1]).

play(Stones) ->
    play(Stones, 0, 0, 0).

play([], _, _, Score) ->
    Score;
play([H|T], Turn, PlayerA, PlayerB) ->
    case Turn of
        0 ->
            NewPlayerA = PlayerA + (lists:last(T) - H),
            play(T, 1, NewPlayerA, PlayerB);
        _ ->
            NewPlayerB = PlayerB + (lists:last(T) - H),
            play(T, 0, PlayerA, NewPlayerB)
    end.