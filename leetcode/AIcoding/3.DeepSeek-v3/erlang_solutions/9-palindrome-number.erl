-spec is_palindrome(X :: integer()) -> boolean().
is_palindrome(X) when X < 0 -> false;
is_palindrome(X) ->
    Original = X,
    Reversed = reverse_num(X, 0),
    Original == Reversed.

reverse_num(0, Acc) -> Acc;
reverse_num(N, Acc) ->
    reverse_num(N div 10, Acc * 10 + N rem 10).