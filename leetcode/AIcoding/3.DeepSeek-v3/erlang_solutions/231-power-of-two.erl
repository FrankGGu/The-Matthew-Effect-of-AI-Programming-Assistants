-spec is_power_of_two(N :: integer()) -> boolean().
is_power_of_two(N) when N =< 0 -> false;
is_power_of_two(N) -> (N band (N - 1)) =:= 0.