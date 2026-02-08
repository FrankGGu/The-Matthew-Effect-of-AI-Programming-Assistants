-module(solution).
-export([min_flips/3]).

min_flips(A, B, C) ->
    MinFlips = fun(A, B, C) ->
        case C band (A bor B) of
            C -> 
                0;
            _ -> 
                (if
                    (C band A) == 0 -> 1;
                    (C band B) == 0 -> 1;
                    true -> 2
                end)
        end
    end,
    MinFlips(A, B, C) + MinFlips(A, B, C bnot A) + MinFlips(A, B, C bnot B).