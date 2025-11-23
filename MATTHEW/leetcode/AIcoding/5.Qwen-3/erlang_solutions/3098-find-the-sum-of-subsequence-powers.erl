-module(solution).
-export([sum_subseq_powers/2]).

sum_subseq_powers(Nums, K) ->
    sum_subseq_powers(Nums, K, 0, 1, 0).

sum_subseq_powers([], _, _, _, Acc) ->
    Acc;
sum_subseq_powers([H | T], K, Index, Power, Acc) ->
    NewAcc = Acc + H * Power,
    sum_subseq_powers(T, K, Index + 1, Power * H, NewAcc).