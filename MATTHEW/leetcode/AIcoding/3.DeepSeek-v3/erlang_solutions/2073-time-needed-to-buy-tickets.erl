-spec time_required_to_buy(Tickets :: [integer()], K :: integer()) -> integer().
time_required_to_buy(Tickets, K) ->
    time_required_to_buy(Tickets, K, 0).

time_required_to_buy([], _, Time) -> Time;
time_required_to_buy([H | T], K, Time) ->
    if
        K =:= 0 ->
            if
                H =:= 1 -> Time + 1;
                true -> time_required_to_buy(T ++ [H - 1], length(T), Time + 1)
            end;
        true ->
            if
                H > 0 -> time_required_to_buy(T ++ [H - 1], K - 1, Time + 1);
                true -> time_required_to_buy(T, K - 1, Time)
            end
    end.