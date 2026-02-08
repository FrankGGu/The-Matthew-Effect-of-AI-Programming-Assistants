-module(solution).
-export([count_words/2]).

count_words(W, L) ->
    Words = lists:foldl(fun (W1, Acc) -> 
        case lists:member(W1 ++ [L], Acc) of
            true -> Acc;
            false -> [W1 ++ [L] | Acc]
        end
    end, [], W),
    length(Words).