-spec is_palindrome(X :: integer()) -> boolean().
is_palindrome(X) when X < 0 -> false;
is_palindrome(X) ->
    Reversed = reverse_integer(X),
    X =:= Reversed.

reverse_integer(0) -> 0;
reverse_integer(X) -> 
    reverse_integer(X, 0).

reverse_integer(0, Acc) -> Acc;
reverse_integer(X, Acc) ->
    reverse_integer(X div 10, Acc * 10 + X rem 10).
