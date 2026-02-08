-spec is_power_of_three(N :: integer()) -> boolean().
is_power_of_three(N) when N =< 0 -> false;
is_power_of_three(1) -> true;
is_power_of_three(N) when N rem 3 =/= 0 -> false;
is_power_of_three(N) -> is_power_of_three(N div 3).