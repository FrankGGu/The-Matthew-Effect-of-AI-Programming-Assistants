-module(restoreIpAddresses).
-export([restoreIpAddresses/1]).

restoreIpAddresses(S) ->
    Len = length(S),
    restoreIpAddressesHelper(S, 0, [], Len).

restoreIpAddressesHelper(S, 4, Acc, _) ->
    case length(S) of
        0 -> [lists:reverse(Acc)];
        _ -> []
    end;
restoreIpAddressesHelper(S, Count, Acc, Len) ->
    Result = [],
    I_max = min(3, length(S)),
    lists:foldl(
        fun(I, Acc1) ->
            Sub = string:substr(S, 1, I),
            case validIpSegment(Sub) of
                true ->
                    Rest = string:substr(S, I + 1, Len - I),
                    NewAcc = [Sub | Acc],
                    Acc1 ++ restoreIpAddressesHelper(Rest, Count + 1, NewAcc, Len);
                false ->
                    Acc1
            end
        end,
        Result,
        lists:seq(1, I_max)
    ).

validIpSegment(S) ->
    case string:to_integer(S) of
        {Num, _} ->
            case Num of
                N when N >= 0, N =< 255 ->
                    case string:equal(string:left(S, 1), "0") of
                        true ->
                            length(S) == 1;
                        false ->
                            true
                    end;
                _ ->
                    false
            end;
        error ->
            false
    end.