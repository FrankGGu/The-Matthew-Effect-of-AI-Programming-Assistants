-module(solution).
-export([countSubstrings/1]).

countSubstrings(S) ->
    Digits = [C - $0 || C <- S],
    Len = length(Digits),

    case Len of
        0 -> 0;
        _ ->
            Divisor = lists:last(Digits),

            if Divisor == 0 ->
                0;
               Divisor == 1 ->
                Len * (Len + 1) div 2;
               true ->
                {D1, D2, K0, Inv10D2} = get_divisor_params(Divisor),

                InitialState = #{
                    total_count => 0,
                    current_prefix_mod_d2 => 0,
                    current_inv_power_of_10_mod_d2 => 1,
                    rem_d2_map => #{0 => 1}
                },

                lists:foldl(fun(J_idx, State) ->
                                update_state(J_idx, Digits, D1, D2, K0, Inv10D2, State)
                            end, InitialState, lists:seq(0, Len - 1))#total_count
            end
    end.

get_divisor_params(Divisor) ->
    case Divisor of
        1 -> {1, 1, 0, 1};
        2 -> {2, 1, 1, 1};
        3 -> {1, 3, 0, 1};
        4 -> {4, 1, 2, 1};
        5 -> {5, 1, 1, 1};
        6 -> {2, 3, 1, 1};
        7 -> {1, 7, 0, 5};
        8 -> {8, 1, 3, 1};
        9 -> {1, 9, 0, 1}
    end.

is_divisible_by_D1(Digits, J, D1, K0) ->
    case K0 of
        0 -> true;
        _ ->
            build_num_from_last_k_digits(Digits, J, K0) rem D1 == 0
    end.

build_num_from_last_k_digits(Digits, J, K) ->
    build_num_from_last_k_digits_recursive(Digits, J, K, 0, 1).

build_num_from_last_k_digits_recursive(_, _, 0, Acc, _) -> Acc;
build_num_from_last_k_digits_recursive(Digits, J, K_remaining, Acc, PowerOf10) when J >= 0 ->
    Digit = lists:nth(J + 1, Digits),
    NewAcc = Acc + Digit * PowerOf10,
    build_num_from_last_k_digits_recursive(Digits, J - 1, K_remaining - 1, NewAcc, PowerOf10 * 10);
build_num_from_last_k_digits_recursive(_, _, _, Acc, _) -> Acc.

update_state(J_idx, Digits, D1, D2, K0, Inv10D2, State) ->
    Digit = lists:nth(J_idx + 1, Digits),

    IsDivisibleByD1 = is_divisible_by_D1(Digits, J_idx, D1, K0),

    CurrentPrefixModD2 = State#current_prefix_mod_d2,
    CurrentInvPowerOf10ModD2 = State#current_inv_power_of_10_mod_d2,
    RemD2Map = State#rem_d2_map,

    NewPrefixModD2 = (CurrentPrefixModD2 * 10 + Digit) rem D2,
    NewInvPowerOf10ModD2 = (CurrentInvPowerOf10ModD2 * Inv10D2) rem D2,

    RemD2ValForJPlus1 = (NewPrefixModD2 * NewInvPowerOf10ModD2) rem D2,

    NewTotalCount = if IsDivisibleByD1 ->
                        maps:get(RemD2ValForJPlus1, RemD2Map, 0) + State#total_count;
                       true ->
                        State#total_count
                    end,

    NewRemD2Map = maps:update_with(RemD2ValForJPlus1, fun(V) -> V + 1 end, 1, RemD2Map),

    State#{total_count => NewTotalCount,
            current_prefix_mod_d2 => NewPrefixModD2,
            current_inv_power_of_10_mod_d2 => NewInvPowerOf10ModD2,
            rem_d2_map => NewRemD2Map}.