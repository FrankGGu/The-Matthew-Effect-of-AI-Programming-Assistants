-module(solution).
-export([min_flips/3]).

min_flips(A, B, C) ->
    min_flips_recursive(A, B, C, 0).

min_flips_recursive(0, 0, 0, AccFlips) ->
    AccFlips;
min_flips_recursive(A, B, C, AccFlips) ->
    CurA = A band 1,
    CurB = B band 1,
    CurC = C band 1,

    NewAccFlips = case CurC of
        0 -> 
            AccFlips + CurA + CurB;
        1 -> 
            case {CurA, CurB} of
                {0, 0} -> AccFlips + 1;
                _      -> AccFlips
            end
    end,

    min_flips_recursive(A bsr 1, B bsr 1, C bsr 1, NewAccFlips).