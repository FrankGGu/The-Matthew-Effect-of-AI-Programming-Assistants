-module(solution).
-export([min_changes/2]).

min_changes(S, K) ->
    N = length(S),
    S1 = string:to_list(S),
    min_changes_helper(S1, K, N, 0).

min_changes_helper(S, K, N, Changes) when K < 0 -> 
    infinity;
min_changes_helper(S, K, N, Changes) when Changes > N -> 
    infinity;
min_changes_helper(S, K, N, Changes) ->
    PalindromeChanges = count_palindrome_changes(S),
    if
        PalindromeChanges + Changes > K -> 
            infinity;
        N == 0 -> 
            Changes;
        true -> 
            min(min_changes_helper(tl(S), K - PalindromeChanges, N - 1, Changes + PalindromeChanges),
                min_changes_helper(tl(S), K, N - 1, Changes))
    end.

count_palindrome_changes(S) ->
    N = length(S),
    Count = lists:foldl(fun({X, Y}, Acc) -> 
        if 
            X =:= Y -> Acc; 
            true -> Acc + 1 
        end 
    end, 0, lists:zip(S, lists:reverse(S))),
    Count.

infinity -> 1#'infinity'.