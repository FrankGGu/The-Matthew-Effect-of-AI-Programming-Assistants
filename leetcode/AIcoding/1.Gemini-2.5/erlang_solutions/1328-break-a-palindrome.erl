-spec break_palindrome(Palindrome :: string()) -> string().
break_palindrome(Palindrome) ->
    Len = length(Palindrome),
    if
        Len =:= 1 ->
            [];
        true ->
            break_palindrome_iter(Palindrome, 1, Len div 2, Len)
    end.

break_palindrome_iter(Palindrome, Index, HalfLen, Len) ->
    if
        Index =< HalfLen ->
            Char = lists:nth(Index, Palindrome),
            if
                Char =/= $a ->
                    lists:replace_nth(Index, $a, Palindrome);
                true ->
                    break_palindrome_iter(Palindrome, Index + 1, HalfLen, Len)
            end;
        true ->
            lists:replace_nth(Len, $b, Palindrome)
    end.