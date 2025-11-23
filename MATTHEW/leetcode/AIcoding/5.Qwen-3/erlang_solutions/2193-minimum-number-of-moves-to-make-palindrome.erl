-module(minimum_number_of_moves_to_make_palindrome).
-export([minMovesToMakePalindrome/1]).

minMovesToMakePalindrome(S) ->
    minMovesToMakePalindrome(S, 0, length(S) - 1, 0).

minMovesToMakePalindrome(_, L, R, Acc) when L >= R ->
    Acc;
minMovesToMakePalindrome(S, L, R, Acc) ->
    case lists:nth(L + 1, S) of
        lists:nth(R + 1, S) ->
            minMovesToMakePalindrome(S, L + 1, R - 1, Acc);
        _ ->
            findMatch(S, L + 1, R, L, Acc)
    end.

findMatch(S, I, R, L, Acc) when I > R ->
    minMovesToMakePalindrome(S, L + 1, R, Acc + 1);
findMatch(S, I, R, L, Acc) ->
    if
        lists:nth(I + 1, S) == lists:nth(R + 1, S) ->
            minMovesToMakePalindrome(S, L, R - 1, Acc + (R - I));
        true ->
            findMatch(S, I + 1, R, L, Acc)
    end.