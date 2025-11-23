-module(solution).
-export([maximumTransferRequests/1]).

maximumTransferRequests(Requests) ->
    N = length(Requests),
    Max = 0,
    lists:foldl(fun(I, Acc) -> 
        case get_balance(Requests, I) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, lists:seq(1, N)).

get_balance(Requests, K) ->
    get_balance(Requests, K, 0).

get_balance([], _, _) -> true;
get_balance([H | T], K, Count) ->
    if
        Count == K ->
            case H of
                [From, To] -> 
                    Balance = lists:foldl(fun([F, T], Acc) -> 
                        Acc + (if F == From -> -1; true -> 0 end) + (if T == To -> 1; true -> 0 end)
                    end, 0, Requests),
                    Balance == 0;
                _ -> false
            end;
        true ->
            get_balance(T, K, Count + 1)
    end.