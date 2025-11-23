-module(solution).
-export([replace_chars/1]).

-spec replace_chars(S :: string()) -> string().
replace_chars(S) ->
    replace_chars_recursive(S, 0, []).

replace_chars_recursive([], _PrevChar, Acc) ->
    lists:reverse(Acc);
replace_chars_recursive([CurrentChar | Rest], PrevChar, Acc) ->
    NewChar =
        if
            CurrentChar == $? ->
                NextChar =
                    case Rest of
                        [] -> 0; % No next character
                        [N|_] -> N % Next character from original string
                    end,
                find_replacement(PrevChar, NextChar);
            true ->
                CurrentChar
        end,
    replace_chars_recursive(Rest, NewChar, [NewChar | Acc]).

find_replacement(Prev, Next) ->
    % Try 'a', 'b', 'c'
    % We need to find the smallest character (a, b, or c) that is not equal to Prev and not equal to Next.
    % Prev and Next can be 0 (sentinel for no character) or an actual character.
    % Note: Next can be $? if the next character in the original string is also '?'.
    % The ASCII value of '?' (63) is different from 'a' (97), 'b' (98), 'c' (99), so it won't conflict.
    TryA = $a,
    TryB = $b,
    TryC = $c,

    if
        TryA /= Prev andalso TryA /= Next -> TryA;
        TryB /= Prev andalso TryB /= Next -> TryB;
        TryC /= Prev andalso TryC /= Next -> TryC
    end.