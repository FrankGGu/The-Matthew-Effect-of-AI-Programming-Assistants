-module(solution).
-export([restore_ip_addresses/1]).

restore_ip_addresses(S) ->
    case length(S) of
        Len when Len < 4; Len > 12 ->
            [];
        _ ->
            restore(S, 4)
    end.

restore(S, 0) ->
    case S of
        [] -> [""];
        _ -> []
    end;
restore(S, N) ->
    lists:foldl(
        fun(I, Acc) ->
            Prefix = string:sub_string(S, 1, I),
            case valid(Prefix) of
                true ->
                    Rest = string:sub_string(S, I + 1),
                    lists:foldl(
                        fun(Suffix, Acc1) ->
                            [Prefix ++ "." ++ Suffix | Acc1]
                        end,
                        Acc,
                        restore(Rest, N - 1)
                    );
                false ->
                    Acc
            end
        end,
        [],
        lists:seq(1, min(3, length(S)))
    ).

valid(S) ->
    case string:to_integer(S) of
        {Num, []} when Num =< 255 ->
            case length(S) of
                1 -> true;
                _ -> hd(S) =/= $0
            end;
        _ ->
            false
    end.