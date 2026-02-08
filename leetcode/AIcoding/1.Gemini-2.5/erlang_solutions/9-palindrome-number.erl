-module(solution).
-export([isPalindrome/1]).

isPalindrome(X) when X < 0 ->
    false;
isPalindrome(X) when X rem 10 == 0 andalso X /= 0 ->
    false;
isPalindrome(X) ->
    isPalindrome_recursive(X, 0).

isPalindrome_recursive(X, ReversedHalf) when X > ReversedHalf ->
    isPalindrome_recursive(X div 10, ReversedHalf * 10 + (X rem 10));
isPalindrome_recursive(X, ReversedHalf) ->
    X == ReversedHalf orelse X == ReversedHalf div 10.