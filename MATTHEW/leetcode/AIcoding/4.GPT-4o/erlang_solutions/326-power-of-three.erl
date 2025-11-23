-spec is_power_of_three(N :: integer()) -> boolean().
is_power_of_three(N) when N > 0 ->
    is_power_of_three(N, 1);
is_power_of_three(_, _) -> 
    false.

is_power_of_three(N, X) when N =:= X -> 
    true;
is_power_of_three(N, X) when N rem X =:= 0 -> 
    is_power_of_three(N, X * 3);
is_power_of_three(_, _) -> 
    false.
