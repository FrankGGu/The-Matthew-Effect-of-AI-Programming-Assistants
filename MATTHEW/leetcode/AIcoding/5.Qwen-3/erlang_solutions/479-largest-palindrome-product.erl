-module(largest_palindrome_product).
-export([largestPalindrome/1]).

largestPalindrome(N) ->
    lists:max([A * B || A <- lists:seq(1, 999), B <- lists:seq(1, 999), is_palindrome(A * B)]).

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).