-module(solution).
-export([sum_of_scores/1]).

sum_of_scores(S) ->
    Length = length(S),
    lists:sum(lists:map(fun(X) -> score(X, Length) end, S)).

score(X, L) ->
    lists:foldl(fun({C, I}, Acc) -> 
                    if 
                        C == $0 -> Acc;
                        C == $1 -> Acc + L - I;
                        true -> Acc + L
                    end
                end, 0, lists:zip(S, lists:seq(1, L)).