-module(count_array_pairs_divisible_by_k).
-export([count_pairs/2]).

gcd(A, 0) -> A;
gcd(0, B) -> B;
gcd(A, B) -> gcd(B, A rem B).

count_pairs(Nums, K) ->
    count_pairs(Nums, K, 0, 0).

count_pairs([], _, _, Acc) ->
    Acc;
count_pairs([H|T], K, I, Acc) ->
    NewAcc = count_pairs(T, K, I+1, Acc),
    count_pairs_inner(T, K, I+1, NewAcc, H).

count_pairs_inner([], _, _, Acc, _) ->
    Acc;
count_pairs_inner([H|T], K, J, Acc, Num1) ->
    if (Num1 * H) rem K == 0 ->
        NewAcc = Acc + 1;
    true ->
        NewAcc = Acc
    end,
    count_pairs_inner(T, K, J+1, NewAcc, Num1).