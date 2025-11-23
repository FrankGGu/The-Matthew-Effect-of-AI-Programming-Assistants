-module(solution).
-export([subarray_lcm/2]).

lcm(A, B) -> (A * B) div math:gcd(A, B).

subarray_lcm(Nums, K) ->
    subarray_lcm_outer(K, Nums, 0).

subarray_lcm_outer(_K, [], AccCount) ->
    AccCount;
subarray_lcm_outer(K, [H_i|T_i], AccCount) ->
    NewAccCount = subarray_lcm_inner(K, 1, [H_i|T_i], AccCount),
    subarray_lcm_outer(K, T_i, NewAccCount).

subarray_lcm_inner(_K, _CurrentLCM, [], AccCount) ->
    AccCount;
subarray_lcm_inner(K, CurrentLCM, [H_j|T_j], AccCount) ->
    if
        H_j > K ->
            AccCount;
        K rem H_j =/= 0 ->
            AccCount;
        true ->
            NewLCM = lcm(CurrentLCM, H_j),
            if
                NewLCM > K ->
                    AccCount;
                NewLCM == K ->
                    subarray_lcm_inner(K, NewLCM, T_j, AccCount + 1);
                true ->
                    subarray_lcm_inner(K, NewLCM, T_j, AccCount)
            end
    end.