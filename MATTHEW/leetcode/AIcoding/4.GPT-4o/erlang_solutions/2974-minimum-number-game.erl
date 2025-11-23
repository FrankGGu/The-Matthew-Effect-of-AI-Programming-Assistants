-module(minimum_number_game).
-export([minimum_number_game/1]).

minimum_number_game(N) when N < 1 ->
    0;
minimum_number_game(N) ->
    minimum_number_game(N, 1).

minimum_number_game(0, Acc) ->
    Acc;
minimum_number_game(N, Acc) ->
    if
        N rem 2 == 0 -> 
            minimum_number_game(N div 2, Acc + 1);
        true -> 
            minimum_number_game(N - 1, Acc)
    end.