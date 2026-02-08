-module(solution).
-export([count_substrings/1]).

count_substrings(S) ->
    N = length(S),
    Count = lists:foldl(fun(_, Acc) -> Acc + count_palindromes(S, N) end, 0, lists:seq(1, N)),
    Count.

count_palindromes(S, N) ->
    lists:foldl(fun(X, Acc) -> Acc + count_odd_palindromes(S, N, X) + count_even_palindromes(S, N, X) end, 0, lists:seq(1, N)).

count_odd_palindromes(S, N, Center) ->
    count_palindrome(S, Center, Center, N).

count_even_palindromes(S, N, Center) ->
    count_palindrome(S, Center, Center + 1, N).

count_palindrome(S, Left, Right, N) ->
    case Left > 0, Right =< N of
        true -> 
            if 
                lists:nth(Left, S) =:= lists:nth(Right, S) ->
                    1 + count_palindrome(S, Left - 1, Right + 1, N);
                true -> 
                    0
            end;
        _ -> 
            0
    end.