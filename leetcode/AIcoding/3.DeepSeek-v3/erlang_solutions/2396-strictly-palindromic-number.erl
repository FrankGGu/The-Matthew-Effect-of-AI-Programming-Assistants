-spec is_strictly_palindromic(N :: integer()) -> boolean().
is_strictly_palindromic(N) ->
    lists:all(fun(B) -> is_palindrome(N, B) end, lists:seq(2, N - 2)).

is_palindrome(N, Base) ->
    Digits = get_digits(N, Base),
    Digits =:= lists:reverse(Digits).

get_digits(0, _) -> [];
get_digits(N, Base) ->
    [N rem Base | get_digits(N div Base, Base)].