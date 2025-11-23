-module(solution).
-export([subarray_gcd/2]).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

subarray_gcd(Nums, K) ->
    subarray_gcd_outer(Nums, K, 0).

subarray_gcd_outer([], _K, Count) -> Count;
subarray_gcd_outer([H|T], K, AccCount) ->
    NewCount = subarray_gcd_inner([H|T], K, H, AccCount),
    subarray_gcd_outer(T, K, NewCount).

subarray_gcd_inner([], _K, _CurrentGCD, Count) -> Count;
subarray_gcd_inner([H|T], K, CurrentGCD, AccCount) ->
    NewGCD = gcd(CurrentGCD, H),

    CountAfterCheck =
        if NewGCD == K -> AccCount + 1;
           true -> AccCount
        end,

    if NewGCD < K ->
        CountAfterCheck;
    true ->
        subarray_gcd_inner(T, K, NewGCD, CountAfterCheck)
    end.