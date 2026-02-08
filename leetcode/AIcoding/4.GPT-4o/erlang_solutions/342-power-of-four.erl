-spec is_power_of_four(N :: integer()) -> boolean().
is_power_of_four(N) when N > 0 ->
    is_power_of_four_helper(N);
is_power_of_four(_) -> false.

is_power_of_four_helper(1) -> true;
is_power_of_four_helper(N) when N rem 4 =:= 0 ->
    is_power_of_four_helper(N div 4);
is_power_of_four_helper(_) -> false.
