-module(solution).
-export([monotonic_pairs/1]).

monotonic_pairs(Nums) ->
    count_pairs_outer(Nums, 0).

count_pairs_outer([], Acc) ->
    Acc;
count_pairs_outer([H_i | T_i], Acc) ->
    NewAcc = count_pairs_inner(H_i, T_i, Acc),
    count_pairs_outer(T_i, NewAcc).

count_pairs_inner(_, [], Acc) ->
    Acc;
count_pairs_inner(H_i, [H_j | T_j], Acc) ->
    Condition = if H_i =< H_j -> 1; true -> 0 end,
    count_pairs_inner(H_i, T_j, Acc + Condition).