-module(make_string_subsequence).
-export([solve/2]).

solve(S1, S2) ->
    solve_helper(S1, S2, 0, 0).

solve_helper(S1, S2, I1, I2) ->
    case {I1 >= length(S1), I2 >= length(S2)} of
        {true, true} -> true;
        {true, false} -> false;
        {false, true} -> true;
        {false, false} ->
            Char1 = element(I1 + 1, S1),
            Char2 = element(I2 + 1, S2),
            if
                Char1 == Char2 ->
                    solve_helper(S1, S2, I1 + 1, I2 + 1);
                (Char1 + 1) rem 26 + $a == Char2 ->
                    solve_helper(S1, S2, I1 + 1, I2 + 1);
                true ->
                    solve_helper(S1, S2, I1 + 1, I2)
            end
    end.