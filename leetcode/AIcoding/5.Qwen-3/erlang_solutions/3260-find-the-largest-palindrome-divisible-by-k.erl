-module(solution).
-export([largest_palindrome/2]).

largest_palindrome(N, K) ->
    Max = 1000000,
    Min = 100000,
    lists:foldl(fun(I, Acc) ->
        case is_palindrome(I) andalso I rem K == 0 of
            true when I > Acc -> I;
            _ -> Acc
        end
    end, -1, lists:seq(Max, Min, -1)).

is_palindrome(N) ->
    S = integer_to_list(N),
    S == lists:reverse(S).