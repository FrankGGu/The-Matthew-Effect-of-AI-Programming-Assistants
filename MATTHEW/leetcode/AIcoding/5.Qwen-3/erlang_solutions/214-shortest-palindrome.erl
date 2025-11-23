-module(shortest_palindrome).
-export([shortest_palindrome/1]).

shortest_palindrome(S) ->
    reverse = fun(X) -> lists:reverse(X) end,
    S_rev = reverse(S),
    N = length(S),
    KMP_failure_function = fun(needle) ->
        Len = length(needle),
        F = lists:seq(0, Len),
        I = 1,
        J = 0,
        KMP_failure_function(needle, F, I, J)
    end,
    KMP_failure_function(needle, F, I, J) when I < length(needle) ->
        if
            J == -1 orelse lists:nth(I+1, needle) == lists:nth(J+1, needle) ->
                lists:sublist(F, I+1) ++ [J+1] ++ lists:sublist(F, I+2, length(F)-I-1);
            true ->
                KMP_failure_function(needle, F, I, lists:nth(J+1, F))
        end;
    KMP_failure_function(_, F, _, _) ->
        F.

shortest_palindrome(S) ->
    S_rev = lists:reverse(S),
    Concat = S ++ "$" ++ S_rev,
    F = KMP_failure_function(Concat),
    N = length(S),
    M = length(F) - 1,
    Pad = lists:duplicate(N - lists:last(F), $a),
    lists:append(Pad, S).