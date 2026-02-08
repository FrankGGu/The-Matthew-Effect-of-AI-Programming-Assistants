-module(restore_ip_addresses).
-export([restore_ip_addresses/1]).

restore_ip_addresses(S) ->
    case length(S) of
        Len when Len < 4; Len > 12 ->
            [];
        _ ->
            restore(S, 1, [])
    end.

restore(S, N, Acc) when N =:= 4 ->
    case is_valid(S) of
        true ->
            [lists:concat(lists:reverse([S | Acc]))];
        false ->
            []
    end;
restore(S, N, Acc) ->
    lists:foldl(
        fun(I, Result) ->
            case I =< length(S) of
                true ->
                    Prefix = string:substr(S, 1, I),
                    case is_valid(Prefix) of
                        true ->
                            Rest = string:substr(S, I + 1),
                            Result ++ restore(Rest, N + 1, [Prefix | Acc]);
                        false ->
                            Result
                    end;
                false ->
                    Result
            end
        end,
        [],
        lists:seq(1, 3)
    ).

is_valid(S) ->
    case S of
        "" -> false;
        _ ->
            case string:to_integer(S) of
                {Num, []} when Num >= 0, Num =< 255 ->
                    case length(S) > 1 of
                        true -> hd(S) =/= $0;
                        false -> true
                    end;
                _ ->
                    false
            end
    end.