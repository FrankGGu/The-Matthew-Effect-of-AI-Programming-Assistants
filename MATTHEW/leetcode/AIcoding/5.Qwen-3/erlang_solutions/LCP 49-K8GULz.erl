-module(solution).
-export([game/1]).

game(Games) ->
    game(Games, 0, 0).

game([], _, _) ->
    0;
game([H|T], Index, Score) ->
    case H of
        1 ->
            game(T, (Index + 1) rem length(Games), Score + 1);
        _ ->
            game(T, (Index + 1) rem length(Games), Score)
    end.