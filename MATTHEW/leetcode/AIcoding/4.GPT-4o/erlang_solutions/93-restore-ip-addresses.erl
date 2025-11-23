%% -spec restore_ip_addresses(S :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
restore_ip_addresses(S) ->
    restore_ip_addresses(S, 0, [], []).

%% Helper function to generate valid IP addresses.
restore_ip_addresses([], _, [], Acc) -> Acc;
restore_ip_addresses([], _, _Parts, Acc) -> Acc;
restore_ip_addresses(S, K, Parts, Acc) when K < 4 ->
    case lists:prefix("0", S) of
        true -> 
            restore_ip_addresses(tl(S), K + 1, [hd(S) | Parts], Acc);
        false -> 
            restore_ip_addresses(tl(S), K + 1, [hd(S) | Parts], Acc)
    end.
