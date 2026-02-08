-module(break_a_palindrome).
-export([break_palindrome/1]).

break_palindrome(S) ->
    N = length(S),
    if
        N == 1 -> "";
        true ->
            L = lists:seq(0, N-1),
            case lists:foldl(fun(I, Acc) ->
                if
                    Acc /= undefined -> Acc;
                    true ->
                        C = lists:nth(I+1, S),
                        if
                            C == $a -> Acc;
                            true ->
                                NewS = lists:sublist(S, I) ++ [$(a)] ++ lists:sublist(S, I+2, N-I-1),
                                lists:flatten(NewS)
                        end
                end
            end, undefined, L) of
                undefined -> lists:sublist(S, N-1) ++ [$b];
                X -> X
            end
    end.