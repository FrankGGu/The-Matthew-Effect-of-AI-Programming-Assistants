-module(solution).
-export([max_product/1]).

max_product(Str) ->
    Palindromes = find_palindromes(Str, []),
    MaxProduct = lists:max(lists:map(fun(X) -> lists:max(lists:map(fun(Y) -> length(X) * length(Y) end, lists:filter(fun(Z) -> Z /= X end, Palindromes))) end, Palindromes)),
    MaxProduct.

find_palindromes(Str, Acc) -> 
    case lists:foldl(fun(_, Acc) -> find_palindromes_helper(Str, Acc) end, Acc, [1]) of
        [] -> Acc;
        NewAcc -> find_palindromes(Str, NewAcc)
    end.

find_palindromes_helper(Str, Acc) ->
    lists:foldl(fun(X, Acc) -> 
        {Ok, Palindrome} = is_palindrome(X, Str),
        case Palindrome of
            true -> lists:append(Acc, [X]);
            false -> Acc
        end
    end, Acc, lists:sublist(Str)).

is_palindrome(X, Str) ->
    SubStr = lists:sublist(Str, X, 1),
    PalindromeStr = lists:reverse(SubStr),
    if
        PalindromeStr =:= SubStr -> {ok, true};
        true -> {ok, false}
    end.