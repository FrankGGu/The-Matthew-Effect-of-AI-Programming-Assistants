-module(solution).
-export([num_subarrays_with_lcm_equal_to_k/2]).

num_subarrays_with_lcm_equal_to_k(Nums, K) ->
    N = length(Nums),
    Count = 0,
    lists:foldl(fun(I, Acc) ->
        LCM = 1,
        lists:foldl(fun(J, Acc2) ->
            Current = lists:nth(J+1, Nums),
            LCM = lcm(LCM, Current),
            if
                LCM == K -> Acc2 + 1;
                true -> Acc2
            end
        end, Acc, lists:seq(I, N-1))
    end, Count, lists:seq(0, N-1)).

lcm(A, B) ->
    A * B div gcd(A, B).

gcd(A, B) when B == 0 ->
    A;
gcd(A, B) ->
    gcd(B, A rem B).