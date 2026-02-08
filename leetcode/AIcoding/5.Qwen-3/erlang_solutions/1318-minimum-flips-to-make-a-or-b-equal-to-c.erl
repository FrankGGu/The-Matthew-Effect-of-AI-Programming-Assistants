-module(solution).
-export([min_flips/3]).

min_flips(A, B, C) ->
    min_flips(A, B, C, 0, 0).

min_flips(0, 0, 0, Acc, _) ->
    Acc;
min_flips(_, _, _, Acc, _) ->
    A1 = A rem 2,
    B1 = B rem 2,
    C1 = C rem 2,
    case (A1 bor B1) of
        C1 ->
            min_flips(A div 2, B div 2, C div 2, Acc, 1);
        _ ->
            case (A1 band B1) of
                C1 ->
                    min_flips(A div 2, B div 2, C div 2, Acc + 1, 1);
                _ ->
                    min_flips(A div 2, B div 2, C div 2, Acc + 2, 1)
            end
    end.