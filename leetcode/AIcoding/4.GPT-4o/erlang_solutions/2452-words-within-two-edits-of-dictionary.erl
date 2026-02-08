-module(solution).
-export([two_edit_words/2]).

two_edit_words(Words, Dict) ->
    lists:filter(fun(W) -> any_two_edits(W, Dict) end, Words).

any_two_edits(W, Dict) ->
    lists:any(fun(D) -> edit_distance(W, D) =< 2 end, Dict).

edit_distance(X, Y) ->
    L1 = length(X),
    L2 = length(Y),
    D = lists:duplicate(L1 + 1, lists:duplicate(L2 + 1, 0)),
    D = fill_distance(D, X, Y, L1, L2),
    lists:last(lists:last(D)).

fill_distance(D, X, Y, L1, L2) ->
    D1 = lists:foldl(fun(_, Acc) -> 
        lists:map(fun({D, I}) -> D + 1 end, lists:zip(Acc, lists:seq(0, L2))) 
        end, lists:seq(0, L2), lists:seq(1, L1)),
    lists:foldl(fun({C, I}, Acc) ->
        lists:foldl(fun({_, J}) ->
            if 
                C == lists:nth(J, Y) -> 
                    lists:nth(I, Acc) + 0; 
                true -> 
                    min(lists:nth(I - 1, Acc) + 1, lists:nth(I, Acc) + 1, lists:nth(I - 1, J) + 1) 
            end 
        end, [], lists:zip(Acc, lists:seq(1, L2))
        )
    end, D1, lists:zip(lists:seq(1, L1), lists:map(fun(X) -> lists:nth(X, X) end, lists:seq(1, L1)))).