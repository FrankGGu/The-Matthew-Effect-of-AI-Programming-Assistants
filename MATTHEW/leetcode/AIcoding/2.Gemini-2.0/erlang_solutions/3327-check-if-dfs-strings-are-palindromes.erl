-module(is_palindrome_after_dfs).
-export([solve/1]).

solve(S) ->
    solve(S, []).

solve([], Acc) ->
    is_palindrome(Acc);
solve([H|T], Acc) ->
    solve(T, [H|Acc]).

is_palindrome([]) ->
    true;
is_palindrome([_]) ->
    true;
is_palindrome(L) ->
    is_palindrome(L, 0, length(L) - 1).

is_palindrome(L, Low, High) when Low >= High ->
    true;
is_palindrome(L, Low, High) ->
    case lists:nth(Low + 1, L) =:= lists:nth(High + 1, L) of
        true ->
            is_palindrome(L, Low + 1, High - 1);
        false ->
            false
    end.