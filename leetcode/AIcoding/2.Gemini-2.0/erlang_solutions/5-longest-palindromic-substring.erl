-module(longest_palindrome).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    Len = length(S),
    case Len of
        0 -> "";
        1 -> S;
        _ -> find_longest_palindrome(S, Len)
    end.

find_longest_palindrome(S, Len) ->
    find_longest_palindrome_helper(S, Len, 0, 0, 1).

find_longest_palindrome_helper(S, Len, Start, MaxLen, CurrLen) ->
    case CurrLen > Len of
        true -> sub_string(S, Start + 1, MaxLen);
        false ->
            NewStart = Start,
            NewMaxLen = MaxLen,
            {NewStart1, NewMaxLen1} = expand_around_center(S, Len, CurrLen div 2, CurrLen div 2, Start, MaxLen),
            {NewStart2, NewMaxLen2} = expand_around_center(S, Len, CurrLen div 2, CurrLen div 2 + 1, NewStart1, NewMaxLen1),
            find_longest_palindrome_helper(S, Len, NewStart2, NewMaxLen2, CurrLen + 1)
    end.

expand_around_center(S, Len, Left, Right, Start, MaxLen) ->
    case Left >= 0 andalso Right < Len of
        true ->
            case lists:nth(Left + 1, S) == lists:nth(Right + 1, S) of
                true ->
                    NewLen = Right - Left + 1,
                    case NewLen > MaxLen of
                        true ->
                            expand_around_center(S, Len, Left - 1, Right + 1, Left, NewLen);
                        false ->
                            expand_around_center(S, Len, Left - 1, Right + 1, Start, MaxLen)
                    end;
                false ->
                    {Start, MaxLen}
            end;
        false ->
            {Start, MaxLen}
    end.