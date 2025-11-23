-module(longest_palindrome_after_substring_concatenation_i).

-export([longestPalindrome/1]).

longestPalindrome(Words) ->
    longestPalindrome(Words, #{}, 0).

longestPalindrome([], _, Acc) ->
    Acc;
longestPalindrome([Word | Rest], Map, Acc) ->
    Reverse = lists:reverse(Word),
    case maps:get(Reverse, Map, 0) of
        0 ->
            longestPalindrome(Rest, maps:update(Word, maps:get(Word, Map, 0) + 1, Map), Acc);
        N ->
            longestPalindrome(Rest, maps:update(Reverse, N - 1, maps:remove(Word, Map)), Acc + 4)
    end.