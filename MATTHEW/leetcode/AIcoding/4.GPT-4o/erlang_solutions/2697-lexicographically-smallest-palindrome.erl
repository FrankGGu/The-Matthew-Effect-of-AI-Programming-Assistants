-module(solution).
-export([make_smallest_palindrome/1]).

make_smallest_palindrome(S) ->
    StringLen = string:length(S),
    HalfLen = StringLen div 2,
    Lists = lists:map(fun(X) -> min(list:nth(X, S), list:nth(StringLen - X + 1, S)) end, lists:seq(1, HalfLen)),
    Palindrome = lists:append(Lists),
    lists:append(Palindrome, lists:reverse(Palindrome)).