-module(restore_ip_addresses).
-export([restore_ip_addresses/1]).

restore_ip_addresses(S) ->
    Len = length(S),
    restore_ip_addresses_helper(S, 0, [], Len).

restore_ip_addresses_helper(_S, 4, Acc, _Len) ->
    [lists:reverse(Acc)];
restore_ip_addresses_helper(S, Count, Acc, Len) ->
    Pos = length(Acc),
    Start = lists:sum([length(X) + 1 || X <- Acc]),

    lists:foldl(fun(Length, Result) ->
                       End = Start + Length,
                       if End > Len orelse Length > 3 then
                           Result
                       else
                           Sub = lists:sublist(S, Start, Length),
                           case is_valid_ip_part(Sub) of
                               true ->
                                   restore_ip_addresses_helper(S, Count + 1, [Sub | Acc], Len) ++ Result;
                               false ->
                                   Result
                           end
                       end
                   end, [], [1, 2, 3]).

is_valid_ip_part(S) ->
    case string:to_integer(S) of
        {Num, _} ->
            case Num > 255 of
                true ->
                    false;
                false ->
                    case length(S) > 1 andalso lists:nth(1, S) == $0 of
                        true ->
                            false;
                        false ->
                            true
                    end
            end;
        error ->
            false
    end.