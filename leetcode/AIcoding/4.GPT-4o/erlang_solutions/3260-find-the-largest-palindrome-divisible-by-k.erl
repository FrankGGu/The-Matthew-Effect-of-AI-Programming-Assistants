-module(solution).
-export([largest_palindrome/2]).

largest_palindrome(N, K) ->
    Max = 10^N - 1,
    Min = 10^(N - 1),
    lists:foldl(fun(X, Acc) ->
        Palindrome = make_palindrome(X),
        if Palindrome rem K == 0 andalso Palindrome >= Min andalso Palindrome =< Max ->
            max(Palindrome, Acc);
        true -> Acc
        end
    end, 0, lists:seq(Max div 10, Max)).

make_palindrome(X) ->
    S = integer_to_list(X),
    PalindromeStr = S ++ lists:reverse(S),
    list_to_integer(PalindromeStr).