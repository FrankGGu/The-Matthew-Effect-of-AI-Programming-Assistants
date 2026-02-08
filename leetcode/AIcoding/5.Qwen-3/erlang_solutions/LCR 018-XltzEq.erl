-module(valid_palindrome).
-export([is_palindrome/1]).

is_palindrome(S) ->
    Clean = lists:filter(fun(C) -> (C >= $a andalso C =< $z) orelse (C >= $A andalso C =< $Z) orelse (C >= $0 andalso C =< $9) end, S),
    Lower = lists:map(fun(C) -> if C >= $A, C =< $Z -> C + 32; true -> C end end, Clean),
    is_palindrome(Lower, 1, length(Lower)).

is_palindrome(_, I, J) when I >= J -> true;
is_palindrome(Lower, I, J) ->
    case lists:nth(I, Lower) of
        X when X == lists:nth(J, Lower) -> is_palindrome(Lower, I + 1, J - 1);
        _ -> false
    end.