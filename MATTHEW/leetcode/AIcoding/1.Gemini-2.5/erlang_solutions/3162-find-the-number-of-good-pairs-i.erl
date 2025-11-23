-module(solution).
-export([numIdenticalPairs/1]).

numIdenticalPairs(Nums) ->
    count_pairs(Nums, 0).

count_pairs([], Acc) ->
    Acc;
count_pairs([H|T], Acc) ->
    PairsWithHead = count_pairs_with_head(H, T, 0),
    count_pairs(T, Acc + PairsWithHead).

count_pairs_with_head(_, [], Acc) ->
    Acc;
count_pairs_with_head(Head, [H2|T2], Acc) ->
    case Head == H2 of
        true ->
            count_pairs_with_head(Head, T2, Acc + 1);
        false ->
            count_pairs_with_head(Head, T2, Acc)
    end.