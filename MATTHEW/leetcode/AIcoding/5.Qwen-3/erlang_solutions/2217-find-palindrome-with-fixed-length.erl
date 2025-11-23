-module(solution).
-export([palindrome/2]).

palindrome(N, K) ->
    Half = (N - 1) div 2,
    Start = trunc(math:pow(10, Half)),
    End = trunc(math:pow(10, Half + 1)) - 1,
    generate_palindromes(Start, End, K).

generate_palindromes(Start, End, K) ->
    generate_palindromes(Start, End, K, []).

generate_palindromes(Start, End, K, Acc) when Start > End ->
    lists:reverse(Acc);
generate_palindromes(Start, End, K, Acc) ->
    Num = Start,
    Left = integer_to_list(Num),
    Right = lists:reverse(Left),
    Palindrome = list_to_integer(Left ++ Right),
    case Palindrome >= K of
        true -> generate_palindromes(Start + 1, End, K, [Palindrome | Acc]);
        false -> generate_palindromes(Start + 1, End, K, Acc)
    end.