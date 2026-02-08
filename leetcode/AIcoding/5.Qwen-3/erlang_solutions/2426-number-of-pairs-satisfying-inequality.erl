-module(solution).
-export([num_pairs/2]).

num_pairs(Nums, k) ->
    num_pairs(Nums, k, 0, 0).

num_pairs([], _, _, Acc) ->
    Acc;
num_pairs([H | T], K, I, Acc) ->
    J = I + 1,
    Count = count_less_than(H, T, K),
    num_pairs(T, K, J, Acc + Count).

count_less_than(_, [], _) ->
    0;
count_less_than(X, [Y | Ys], K) ->
    if
        X - Y =< K ->
            1 + count_less_than(X, Ys, K);
        true ->
            count_less_than(X, Ys, K)
    end.