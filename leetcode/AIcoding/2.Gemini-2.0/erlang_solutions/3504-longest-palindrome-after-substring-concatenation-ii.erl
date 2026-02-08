-module(longest_palindrome_substring_concatenation_ii).
-export([longestPalindrome/1]).

longestPalindrome(Words) ->
    longestPalindrome(Words, #{}, 0).

longestPalindrome([], _Counts, Acc) ->
    Acc;
longestPalindrome([Word | Rest], Counts, Acc) ->
    case maps:get(Word, Counts, 0) of
        0 ->
            Reversed = lists:reverse(Word);
            NewCounts = maps:put(Reversed, maps:get(Reversed, Counts, 0) + 1, Counts);
            longestPalindrome(Rest, NewCounts, Acc);
        N ->
            Reversed = lists:reverse(Word);
            NewCounts = maps:update(Word, N - 1, Counts);
            longestPalindrome(Rest, NewCounts, Acc + 4)
    end.