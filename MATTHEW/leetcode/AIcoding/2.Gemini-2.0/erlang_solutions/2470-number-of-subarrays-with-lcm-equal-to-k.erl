-module(solution).
-export([num_subarray_lcm_k/2]).

lcm(A, B) ->
    gcd(A, B) ->
        gcd_helper(A, B);
    A * B div gcd(A, B).

gcd_helper(A, 0) -> A;
gcd_helper(A, B) -> gcd_helper(B, A rem B).

num_subarray_lcm_k(Nums, K) ->
    num_subarray_lcm_k_helper(Nums, K, 0).

num_subarray_lcm_k_helper([], _, Acc) ->
    Acc;
num_subarray_lcm_k_helper([H|T], K, Acc) ->
    num_subarray_lcm_k_helper(T, K, Acc + count_subarrays(H, T, K, H, 0)).

count_subarrays(H, T, K, CurrentLCM, Acc) ->
    if
        CurrentLCM > K ->
            Acc;
        CurrentLCM == K ->
            case T of
                [] -> Acc + 1;
                [Next|Rest] ->
                    NewLCM = lcm(CurrentLCM, Next);
                    count_subarrays(Next, Rest, K, NewLCM, Acc + 1)
            end;
        true ->
            case T of
                [] -> Acc;
                [Next|Rest] ->
                    NewLCM = lcm(CurrentLCM, Next);
                    count_subarrays(Next, Rest, K, NewLCM, Acc)
            end
    end.