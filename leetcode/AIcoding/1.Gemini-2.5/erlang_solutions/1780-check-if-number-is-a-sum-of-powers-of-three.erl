-module(solution).
-export([check_powers_of_three/1]).

-spec check_powers_of_three(N :: integer()) -> boolean().
check_powers_of_three(N) ->
    check_powers_of_three_recursive(N).

check_powers_of_three_recursive(0) ->
    true;
check_powers_of_three_recursive(N) when N > 0 ->
    Remainder = N rem 3,
    if
        Remainder == 2 ->
            false;
        true ->
            check_powers_of_three_recursive(N div 3)
    end.