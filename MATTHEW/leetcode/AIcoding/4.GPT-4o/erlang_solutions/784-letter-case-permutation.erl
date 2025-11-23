-module(solution).
-export([letter_case_permutation/1]).

letter_case_permutation(S) ->
    letter_case_permutation(S, []).

letter_case_permutation([], Acc) ->
    [lists:reverse(Acc)];
letter_case_permutation([H | T], Acc) ->
    case H of
        $0 -> letter_case_permutation(T, [H | Acc]);
        $1 -> letter_case_permutation(T, [H | Acc]);
        $2 -> letter_case_permutation(T, [H | Acc]);
        $3 -> letter_case_permutation(T, [H | Acc]);
        $4 -> letter_case_permutation(T, [H | Acc]);
        $5 -> letter_case_permutation(T, [H | Acc]);
        $6 -> letter_case_permutation(T, [H | Acc]);
        $7 -> letter_case_permutation(T, [H | Acc]);
        $8 -> letter_case_permutation(T, [H | Acc]);
        $9 -> letter_case_permutation(T, [H | Acc]);
        _ -> 
            letter_case_permutation(T, [upper_case(H) | Acc]) ++ 
            letter_case_permutation(T, [lower_case(H) | Acc])
    end.

upper_case(Char) -> 
    lists:to_upper([Char]).

lower_case(Char) -> 
    lists:to_lower([Char]).