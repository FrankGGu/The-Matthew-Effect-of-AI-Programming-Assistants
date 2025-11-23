-module(max_product_of_length_of_two_palindromic_subsequences).
-export([max_palindrome_product/1]).

max_palindrome_product(S) ->
    Palindromes = generate_palindromic_subsequences(S),
    lists:foldl(fun(P1, Acc) ->
        lists:foldl(fun(P2, Acc2) ->
            if P1 /= P2 andalso length(P1) * length(P2) > Acc2 ->
                length(P1) * length(P2);
               true ->
                Acc2
            end
        end, Acc, Palindromes)
    end, 0, Palindromes).

generate_palindromic_subsequences(S) ->
    generate_palindromic_subsequences(S, []).

generate_palindromic_subsequences([], Acc) ->
    Acc;
generate_palindromes(S) ->
    generate_palindromes(S, [], []).

generate_palindromes([], _, Acc) ->
    Acc;
generate_palindromes([C | T], Path, Acc) ->
    NewPath = [C | Path],
    case is_palindrome(NewPath) of
        true -> generate_palindromes(T, NewPath, [NewPath | Acc]);
        false -> generate_palindromes(T, NewPath, Acc)
    end,
    generate_palindromes(T, Path, Acc).

is_palindrome(List) ->
    List == lists:reverse(List).