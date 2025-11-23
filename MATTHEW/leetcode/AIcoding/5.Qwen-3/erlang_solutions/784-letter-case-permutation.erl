-module(letter_case_permutation).
-export([letter_case_permutation/1]).

letter_case_permutation(S) ->
    Perms = permute(S, 0),
    lists:usort(Perms).

permute([], _) ->
    [""];
permute([H|T], Index) ->
    case is_digit(H) of
        true ->
            [H ++ P || P <- permute(T, Index + 1)];
        false ->
            [string:to_lower([H]) ++ P || P <- permute(T, Index + 1)] ++
            [string:to_upper([H]) ++ P || P <- permute(T, Index + 1)]
    end.

is_digit(C) ->
    C >= $0 andalso C =< $9.