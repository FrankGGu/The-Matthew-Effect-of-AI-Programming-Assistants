-module(solution).
-export([check_if_number_is_sum_of_powers_of_three/1]).

check_if_number_is_sum_of_powers_of_three(N) ->
    check(N).

check(0) ->
    true;
check(N) when N rem 3 == 0 ->
    check(N div 3);
check(N) when N rem 3 == 1 ->
    check(N div 3);
check(_) ->
    false.