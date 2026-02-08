-module(solution).
-export([count_pairs/2]).

-spec count_pairs(Nums :: [integer()], K :: integer()) -> integer().
count_pairs(Nums, K) ->
    count_pairs_recursive(Nums, K, 0).

count_pairs_recursive([], _K, Acc) ->
    Acc;
count_pairs_recursive([H | T], K, Acc) ->
    NewAcc = count_pairs_with_head(H, T, K, Acc),
    count_pairs_recursive(T, K, NewAcc).

count_pairs_with_head(_H, [], _K, Acc) ->
    Acc;
count_pairs_with_head(H, [H2 | T2], K, Acc) ->
    Diff = abs(H - H2),
    case Diff of
        K -> count_pairs_with_head(H, T2, K, Acc + 1);
        _ -> count_pairs_with_head(H, T2, K, Acc)
    end.