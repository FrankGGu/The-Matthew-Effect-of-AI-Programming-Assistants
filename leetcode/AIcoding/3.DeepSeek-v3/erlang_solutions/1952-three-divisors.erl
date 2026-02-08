-spec is_three(N :: integer()) -> boolean().
is_three(N) ->
    case N < 4 of
        true -> false;
        false ->
            Divisors = lists:filter(fun(D) -> N rem D =:= 0 end, lists:seq(1, N)),
            length(Divisors) =:= 3
    end.