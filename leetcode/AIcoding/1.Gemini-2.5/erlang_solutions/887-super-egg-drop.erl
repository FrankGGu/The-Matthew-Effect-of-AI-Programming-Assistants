-module(solution).
-export([superEggDrop/2]).

superEggDrop(K, N) ->
    solve(0, #{}, K, N).

solve(M_prev, PrevDP, K_total, N_total) ->
    M_curr = M_prev + 1,
    K_loop_limit = erlang:min(K_total, M_curr),
    NewDP = calculate_new_dp_for_m(M_prev, PrevDP, K_loop_limit),
    ResultFloors = maps:get(K_loop_limit, NewDP, 0),

    if
        ResultFloors >= N_total -> M_curr;
        true -> solve(M_curr, NewDP, K_total, N_total)
    end.

calculate_new_dp_for_m(M_prev, PrevDP, K_loop_limit) ->
    lists:foldl(
        fun(K_val, AccDP) ->
            Val = 1 + get_prev_dp_val(K_val - 1, M_prev, PrevDP) + get_prev_dp_val(K_val, M_prev, PrevDP),
            maps:put(K_val, Val, AccDP)
        end,
        #{},
        lists:seq(1, K_loop_limit)
    ).

get_prev_dp_val(K_val, M_prev_val, PrevDP_map) ->
    EffectiveK_val = erlang:min(K_val, M_prev_val),
    maps:get(EffectiveK_val, PrevDP_map, 0).