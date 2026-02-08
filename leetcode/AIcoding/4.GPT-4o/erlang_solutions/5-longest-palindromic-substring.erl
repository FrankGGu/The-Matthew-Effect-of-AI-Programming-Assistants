-spec longest_palindrome(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
longest_palindrome(S) ->
    longest_palindrome(S, 0, 0, 0, 0, 0).

longest_palindrome([], _, _, MaxStart, MaxLen, _) -> 
    lists:sublist([], MaxStart + 1, MaxLen);
longest_palindrome([_ | T], Start, End, MaxStart, MaxLen, MaxEnd) ->
    case is_palindrome(Start, End, T) of
        true -> 
            longest_palindrome(T, End, End + 1, End, MaxLen + 1, MaxEnd + 1);
        false -> 
            longest_palindrome(T, Start, End, MaxStart, MaxLen, MaxEnd)
    end.

is_palindrome(Start, End, _Tail) -> 
    Start == End.

