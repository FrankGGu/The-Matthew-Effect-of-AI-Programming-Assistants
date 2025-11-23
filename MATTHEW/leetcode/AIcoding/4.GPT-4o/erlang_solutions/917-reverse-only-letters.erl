-module(solution).
-export([reverse_only_letters/1]).

reverse_only_letters(S) ->
    Letters = lists:filter(fun(C) -> is_letter(C) end, S),
    ReverseLetters = lists:reverse(Letters),
    replace_letters(S, ReverseLetters, 0).

is_letter(C) ->
    (C >= $a, C =< $z) orelse (C >= $A, C =< $Z).

replace_letters([], _, _) -> [];
replace_letters([H | T], ReverseLetters, Index) ->
    if
        is_letter(H) ->
            [lists:nth(Index + 1, ReverseLetters) | replace_letters(T, ReverseLetters, Index + 1)];
        true ->
            [H | replace_letters(T, ReverseLetters, Index)]
    end.