-module(solution).
-export([countAlmostEqualPairs/1]).

countAlmostEqualPairs(Nums) ->
    count_pairs_recursive(Nums, 0).

count_pairs_recursive([], Acc) ->
    Acc;
count_pairs_recursive([H|T], Acc) ->
    PairsWithH = lists:foldl(fun(X, CurrentCount) ->
                                 if abs(H - X) =< 1 -> CurrentCount + 1;
                                    true -> CurrentCount
                                 end
                             end, 0, T),
    count_pairs_recursive(T, Acc + PairsWithH).