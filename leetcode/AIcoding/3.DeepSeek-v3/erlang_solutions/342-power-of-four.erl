-spec is_power_of_four(N :: integer()) -> boolean().
is_power_of_four(N) when N =< 0 -> false;
is_power_of_four(N) ->
    (N band (N - 1)) =:= 0 andalso (N band 16#55555555) =:= N.