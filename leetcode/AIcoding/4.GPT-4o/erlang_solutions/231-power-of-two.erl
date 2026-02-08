-spec is_power_of_two(N :: integer()) -> boolean().
is_power_of_two(N) when N > 0, N band (N - 1) =:= 0 -> true;
is_power_of_two(_) -> false.
