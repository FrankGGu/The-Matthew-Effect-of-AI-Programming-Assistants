-module(solution).
-export([check_powers_of_three/1]).

check_powers_of_three(N) ->
    check_powers_of_three(N, 0).

check_powers_of_three(0, _) ->
    true;
check_powers_of_three(N, Power) ->
    case N rem 3 of
        0 -> check_powers_of_three(N div 3, Power + 1);
        1 -> check_powers_of_three(N div 3, Power + 1);
        _ -> false
    end.