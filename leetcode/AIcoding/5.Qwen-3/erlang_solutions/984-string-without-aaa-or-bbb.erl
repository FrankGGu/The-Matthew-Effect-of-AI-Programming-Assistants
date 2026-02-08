-module(solution).
-export([str_without_a_or_b/2]).

str_without_a_or_b(A, B) ->
    str_without_a_or_b(A, B, "", 0, 0).

str_without_a_or_b(0, 0, Acc, _, _) ->
    Acc;
str_without_a_or_b(A, B, Acc, CountA, CountB) ->
    ChooseA = (A > 0) andalso ((CountA < 2) orelse (CountB >= 2)),
    ChooseB = (B > 0) andalso ((CountB < 2) orelse (CountA >= 2)),

    if
        ChooseA and ChooseB ->
            case rand:uniform(2) of
                1 -> str_without_a_or_b(A - 1, B, Acc ++ "a", CountA + 1, 0);
                2 -> str_without_a_or_b(A, B - 1, Acc ++ "b", 0, CountB + 1)
            end;
        ChooseA ->
            str_without_a_or_b(A - 1, B, Acc ++ "a", CountA + 1, 0);
        ChooseB ->
            str_without_a_or_b(A, B - 1, Acc ++ "b", 0, CountB + 1)
    end.