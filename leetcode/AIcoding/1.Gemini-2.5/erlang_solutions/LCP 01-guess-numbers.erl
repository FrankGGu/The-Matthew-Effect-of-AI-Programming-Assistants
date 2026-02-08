-module(solution).
-export([game/2]).

game(Guess, Answer) ->
    case Guess == Answer of
        true -> 1;
        false -> 0
    end.