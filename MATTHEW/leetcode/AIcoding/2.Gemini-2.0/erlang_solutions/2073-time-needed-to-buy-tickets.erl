-module(time_needed_to_buy_tickets).
-export([num_of_seconds/2]).

num_of_seconds(Tickets, K) ->
    num_of_seconds(Tickets, K, 0).

num_of_seconds([], _, Acc) ->
    Acc;
num_of_seconds(Tickets, K, Acc) ->
    num_of_seconds(Tickets, K, Acc, 0).

num_of_seconds(Tickets, K, Acc, I) ->
    case Tickets of
        [] ->
            Acc;
        [H | T] ->
            case H > 0 of
                true ->
                    case I =:= K of
                        true ->
                            Acc + 1 + num_of_seconds([max(0,X-1) || X <- T], K - 1, 0, 0);
                        false ->
                            num_of_seconds(T ++ [max(0,H-1)], K, Acc + 1, I+1)
                    end;
                false ->
                    num_of_seconds(T, K, Acc, I)
            end
    end.