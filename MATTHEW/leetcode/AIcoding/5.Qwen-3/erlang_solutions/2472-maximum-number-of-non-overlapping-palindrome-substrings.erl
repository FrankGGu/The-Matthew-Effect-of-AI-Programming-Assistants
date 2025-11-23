-module(max_non_overlapping_palindromes).
-export([max_num_non_overlapping_palindromes/1]).

max_num_non_overlapping_palindromes(S) ->
    N = length(S),
    Palindromes = generate_palindromes(S),
    DP = array:new(N + 1, {default, 0}),
    lists:foldl(fun({Start, End}, Acc) ->
        Max = max(array:get(Start, Acc), array:get(End + 1, Acc)),
        array:set(End + 1, Max + 1, Acc)
    end, DP, Palindromes).

generate_palindromes(S) ->
    N = length(S),
    Palindromes = [],
    generate_palindromes(S, 0, N - 1, Palindromes).

generate_palindromes(S, Left, Right, Acc) when Left > Right ->
    Acc;
generate_palindromes(S, Left, Right, Acc) ->
    case is_palindrome(S, Left, Right) of
        true ->
            generate_palindromes(S, Left + 1, Right, [{Left, Right} | Acc]);
        false ->
            generate_palindromes(S, Left + 1, Right, Acc)
    end.

is_palindrome(S, Left, Right) ->
    is_palindrome(S, Left, Right, 0).

is_palindrome(S, Left, Right, I) when Left + I > Right - I ->
    true;
is_palindrome(S, Left, Right, I) ->
    if
        string:at(S, Left + I) /= string:at(S, Right - I) ->
            false;
        true ->
            is_palindrome(S, Left, Right, I + 1)
    end.