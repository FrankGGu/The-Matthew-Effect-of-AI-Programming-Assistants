-module(largest_palindrome_divisible_by_k).
-export([largest_palindrome/1]).

largest_palindrome(N) ->
    case N of
        1 -> "9";
        _ ->
            Max = math:pow(10, N) - 1,
            Min = math:pow(10, N-1),
            largestPalindrome(Max, Min, N)
    end.

largestPalindrome(Max, Min, N) ->
    case Max of
        Num when Num < Min ->
            "";
        Num ->
            case isPalindromeDivisible(Num) of
                true ->
                    integer_to_list(Num);
                false ->
                    largestPalindrome(Num-1, Min, N)
            end
    end.

isPalindromeDivisible(Num) ->
    K = 1337,
    Num rem K == 0 andalso isPalindrome(integer_to_list(Num)).

isPalindrome(Str) ->
    Str == lists:reverse(Str).