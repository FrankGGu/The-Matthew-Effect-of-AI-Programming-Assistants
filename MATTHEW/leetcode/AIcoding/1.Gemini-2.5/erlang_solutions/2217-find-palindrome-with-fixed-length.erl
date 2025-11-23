-module(solution).
-export([find_palindrome/2]).

find_palindrome(Queries, IntLength) ->
    HalfLen = (IntLength + 1) div 2,
    MinFirstHalf = pow10(HalfLen - 1),
    MaxFirstHalf = pow10(HalfLen) - 1,
    lists:map(fun(Q) ->
        find_palindrome_for_query(Q, IntLength, HalfLen, MinFirstHalf, MaxFirstHalf)
    end, Queries).

find_palindrome_for_query(Q, IntLength, HalfLen, MinFirstHalf, MaxFirstHalf) ->
    CurrentHalfNum = MinFirstHalf + Q - 1,
    if
        CurrentHalfNum > MaxFirstHalf ->
            -1;
        true ->
            FirstHalfStr = integer_to_list(CurrentHalfNum),
            SuffixLen = IntLength - HalfLen,
            ReversedSuffixStr = lists:reverse(lists:sublist(FirstHalfStr, 1, SuffixLen)),
            PalindromeStr = FirstHalfStr ++ ReversedSuffixStr,
            list_to_integer(PalindromeStr)
    end.

pow10(0) -> 1;
pow10(N) when N > 0 -> 10 * pow10(N - 1).