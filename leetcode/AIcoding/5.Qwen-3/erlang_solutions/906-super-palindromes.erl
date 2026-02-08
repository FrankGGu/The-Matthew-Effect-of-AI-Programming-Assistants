-module(solve).
-export([super_palindromes/1]).

super_palindromes(UpTo) ->
    Max = list_to_integer(UpTo),
    Count = 0,
    Limit = trunc(math:sqrt(Max)) + 1,
    generate_palindromes(1, Limit, 0, Max, Count).

generate_palindromes(I, Limit, Acc, Max, Count) when I > Limit ->
    Count;
generate_palindromes(I, Limit, Acc, Max, Count) ->
    Pal1 = integer_to_list(I),
    Pal2 = lists:reverse(Pal1),
    Pal = list_to_integer(Pal1 ++ Pal2),
    if
        Pal > Max -> generate_palindromes(I + 1, Limit, Acc, Max, Count);
        true ->
            case is_palindrome(Pal * Pal) of
                true -> generate_palindromes(I + 1, Limit, Acc + 1, Max, Count);
                false -> generate_palindromes(I + 1, Limit, Acc, Max, Count)
            end
    end.

is_palindrome(N) ->
    Str = integer_to_list(N),
    Str == lists:reverse(Str).