-module(maximum_product_of_palindromic_subsequences).
-export([max_product/1]).

max_product(Str) ->
    N = length(Str),
    Palindromes = [get_palindrome(Str, I, J) || I <- lists:seq(1, N), J <- lists:seq(I, N)],
    Products = [length(Pal1) * length(Pal2) || {Pal1, Pal2} <- lists:seq(1, N) ++ lists:seq(1, N), Pal1 = element(1, lists:nth(Pal1, Palindromes)), Pal2 = element(1, lists:nth(Pal2, Palindromes)), Pal1 /= Pal2],
    lists:max(Products).

get_palindrome(Str, I, J) ->
    SubStr = lists:sublist(Str, I, J - I + 1),
    if
        is_palindrome(SubStr) -> SubStr;
        true -> []
    end.

is_palindrome(Str) ->
    Str == lists:reverse(Str).