-module(orderly_queue).
-export([orderly_queue/1]).

orderly_queue(S) ->
    order(S, 0).

order(S, N) ->
    case S of
        [] -> [];
        _ ->
            Min = lists:min(S),
            Index = lists:foldl(fun(I, Acc) -> 
                if lists:nth(I+1, S) == Min -> I;
                   true -> Acc end
            end, -1, lists:seq(0, length(S)-1)),
            if Index == -1 -> S;
               true -> 
                    [lists:nth(Index+1, S) | order(lists:sublist(S, Index+2, length(S)-(Index+1)) ++ lists:sublist(S, 1, Index), N+1)]
            end
    end.