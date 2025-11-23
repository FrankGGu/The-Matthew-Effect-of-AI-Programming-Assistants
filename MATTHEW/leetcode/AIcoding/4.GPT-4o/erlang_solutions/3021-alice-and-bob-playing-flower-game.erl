-module(solution).
-export([flower_game/1]).

flower_game(N) when N > 0 ->
    case N rem 4 of
        1 -> "Alice";
        2 -> "Bob";
        3 -> "Alice";
        0 -> "Bob"
    end.