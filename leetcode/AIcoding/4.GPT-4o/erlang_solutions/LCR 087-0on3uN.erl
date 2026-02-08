-module(solution).
-export([restore_ip_addresses/1]).

restore_ip_addresses(S) ->
    restore_ip_addresses(S, 0, [], []).

restore_ip_addresses([], _, Acc, Res) ->
    case length(Acc) of
        4 -> [string:join(Acc, ".") | Res];
        _ -> Res
    end;
restore_ip_addresses(S, Start, Acc, Res) ->
    lists:foldl(
        fun(X, Acc1) ->
            case lists:nthtail(Start, S) of
                [] -> Acc1;
                [H | _] when H =< 0 -> Acc1;
                _ when length(X) > 3 -> Acc1;
                _ -> 
                    case lists:foldl(
                        fun(Y, Acc2) ->
                            case binary_to_integer(Y) of
                                I when I >= 0, I =< 255 -> 
                                    restore_ip_addresses(lists:sublist(S, Start + length(Y)), Start + length(Y), [Y | Acc] ++ Acc2);
                                _ -> Acc2
                            end
                        end,
                        Acc1,
                        [string:substring(S, Start, X) || X <- [1, 2, 3]]
                    ) of
                        [] -> Acc1;
                        NewAcc -> NewAcc
                    end
            end
        end,
        Acc,
        [1, 2, 3]
    ).