-module(solution).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    Length = string:length(S),
    MaxLength = 0,
    lists:foldl(fun(X, Acc) -> 
        {Left, Right} = split(S, X),
        PalindromeLength = palindrome_length(Left) + palindrome_length(Right),
        max(PalindromeLength, Acc)
    end, MaxLength, lists:seq(1, Length).

split(S, Index) ->
    {string:substr(S, 1, Index), string:substr(S, Index + 1, string:length(S) - Index)}.

palindrome_length(Str) ->
    case lists:reverse(Str) == Str of
        true -> string:length(Str);
        false -> 0
    end.