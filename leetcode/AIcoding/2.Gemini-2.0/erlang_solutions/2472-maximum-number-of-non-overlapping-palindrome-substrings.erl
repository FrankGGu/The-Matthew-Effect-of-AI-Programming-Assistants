-module(max_non_overlapping_palindromes).
-export([max_non_overlapping_palindromes/1]).

max_non_overlapping_palindromes(S) ->
    N = length(S),
    dp(S, 0, N, #{}).

dp(_S, I, N, Memo) when I >= N ->
    0;
dp(S, I, N, Memo) ->
    case maps:get(I, Memo, undefined) of
        undefined ->
            Ans1 = dp(S, I + 1, N, Memo),
            Ans2 = lists:foldl(
                       fun(J, Acc) ->
                           Sub = lists:sublist(S, I + 1, J - I),
                           if
                               is_palindrome(Sub) ->
                                   max(Acc, 1 + dp(S, J, N, Memo));
                               true ->
                                   Acc
                           end
                       end,
                       0,
                       lists:seq(I + 1, N)
                   ),
            Result = max(Ans1, Ans2),
            Memo1 = maps:put(I, Result, Memo),
            Result;
        Val ->
            Val
    end.

is_palindrome(S) ->
    S =:= lists:reverse(S).