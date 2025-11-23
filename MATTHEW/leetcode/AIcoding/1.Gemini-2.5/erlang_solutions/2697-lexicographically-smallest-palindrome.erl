-module(lexicographically_smallest_palindrome).
-export([makeSmallestPalindrome/1]).

makeSmallestPalindrome(S) ->
    Arr = array:from_list(S),
    N = array:size(Arr),
    makeSmallestPalindrome_recursive(0, N div 2, N, Arr).

makeSmallestPalindrome_recursive(I, MaxI, N, CurrentArr) when I < MaxI ->
    CharI = array:get(I, CurrentArr),
    CharJ = array:get(N - 1 - I, CurrentArr),
    NewArr = 
        if
            CharI < CharJ -> array:set(N - 1 - I, CharI, CurrentArr);
            CharI > CharJ -> array:set(I, CharJ, CurrentArr);
            true -> CurrentArr
        end,
    makeSmallestPalindrome_recursive(I + 1, MaxI, N, NewArr);
makeSmallestPalindrome_recursive(_I, _MaxI, _N, CurrentArr) ->
    array:to_list(CurrentArr).