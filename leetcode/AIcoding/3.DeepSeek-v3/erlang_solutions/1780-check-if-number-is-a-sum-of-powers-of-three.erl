-spec is_power_of_three(N :: integer()) -> boolean().
is_power_of_three(N) ->
    N > 0 andalso 1162261467 rem N =:= 0.

-spec check_powers_of_three(N :: integer()) -> boolean().
check_powers_of_three(N) ->
    case N < 1 of
        true -> false;
        false ->
            case N rem 3 of
                0 -> check_powers_of_three(N div 3);
                1 -> check_powers_of_three(N div 3);
                _ -> false
            end
    end.