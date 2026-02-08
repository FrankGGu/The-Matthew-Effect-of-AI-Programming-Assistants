-module(solution).
-export([digit_game_won/2]).

digit_game_won(N, X) ->
    case N rem 9 of
        0 -> 
            case X rem 9 of
                0 -> true;
                _ -> false
            end;
        R -> 
            case X rem 9 of
                R -> true;
                _ -> false
            end
    end.