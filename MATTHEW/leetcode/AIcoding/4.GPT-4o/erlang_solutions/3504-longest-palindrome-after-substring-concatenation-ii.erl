-module(solution).
-export([longest_palindrome/1]).

longest_palindrome(S) ->
    L = length(S),
    MaxLen = L div 2,
    lists:foldl(fun(X, Acc) ->
        case lists:prefix(S, lists:duplicate(X, 2)) of
            true -> max(2 * X, Acc);
            false -> Acc
        end
    end, 1, lists:seq(1, MaxLen)).