-module(number_of_subarrays_with_gcd_equal_to_k).
-export([number_of_subarrays/2]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

number_of_subarrays(Nums, K) ->
    number_of_subarrays(Nums, K, 0, 0).

number_of_subarrays([], _, Acc, _) -> Acc;
number_of_subarrays([H|T], K, Acc, I) ->
    number_of_subarrays(T, K, Acc + count_subarrays_with_gcd(lists:sublist(Nums, I+1), K, 0), I+1).

count_subarrays_with_gcd([], _, Acc) -> Acc;
count_subarrays_with_gcd([H|T], K, Acc) ->
    count_subarrays_with_gcd(T, K, Acc + (if gcd(H, K) == K -> 1 else 0), H, K).

count_subarrays_with_gcd([], _, Acc, _, _) -> Acc;
count_subarrays_with_gcd([H|T], K, Acc, CurrentGCD, K) ->
  count_subarrays_with_gcd(T, K, Acc + (if gcd(H, K) == K -> 1 else 0), gcd(CurrentGCD, H), K);
count_subarrays_with_gcd([H|T], K, Acc, CurrentGCD, K) when CurrentGCD /= K ->
  count_subarrays_with_gcd(T, K, Acc, CurrentGCD, K);

count_subarrays_with_gcd([H|T], K, Acc, CurrentGCD, K) ->
  NewGCD = gcd(CurrentGCD, H),
  count_subarrays_with_gcd(T, K, Acc + (if NewGCD == K -> 1 else 0), NewGCD, K).

count_subarrays_with_gcd(Nums, K, Acc) ->
  count_subarrays_with_gcd(Nums, K, Acc, 0, K).

number_of_subarrays(Nums, K, Acc, I) ->
    SubArrays = lists:sublist(Nums, I+1),
    number_of_subarrays(Nums, K, Acc + count_subarrays(SubArrays, K, 0), I+1).

count_subarrays([], _, Acc) -> Acc;
count_subarrays(Nums, K, Acc) ->
    count_subarrays(Nums, K, Acc, 0).

count_subarrays(Nums, K, Acc, StartIndex) ->
    Len = length(Nums),
    if StartIndex >= Len ->
        Acc
    else
        count_subarrays(Nums, K, Acc + check_subarrays(lists:sublist(Nums, StartIndex + 1)), StartIndex + 1).

check_subarrays(SubList) ->
    check_subarrays(SubList, 0).

check_subarrays([], _) -> 0;
check_subarrays([H|T], Acc) -> check_subarrays(T, Acc + (if gcd_list([H|T]) == H-> 1 else 0)).

gcd_list([X]) -> X;
gcd_list([H|T]) -> gcd(H, gcd_list(T)).

number_of_subarrays(Nums, K, Acc) ->
    number_of_subarrays(Nums, K, Acc, 0).