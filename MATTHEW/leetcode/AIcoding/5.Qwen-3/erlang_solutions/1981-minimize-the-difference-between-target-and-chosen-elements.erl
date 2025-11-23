-module(solution).
-export([minimize_target_diff/2]).

minimize_target_diff(Target, Numbers) ->
    lists:min([abs(Target - N) || N <- Numbers]).

minimize_target_diff(Target, Numbers, K) ->
    minimize_target_diff(Target, Numbers, K, []).

minimize_target_diff(_, _, 0, Acc) ->
    lists:min(Acc);
minimize_target_diff(Target, Numbers, K, Acc) ->
    [Min | _] = lists:sort(Numbers),
    NewAcc = [abs(Target - Min) | Acc],
    minimize_target_diff(Target, lists:delete(Min, Numbers), K-1, NewAcc).

minimize_target_diff(Target, Numbers) ->
    case length(Numbers) of
        L when L =< 50 ->
            lists:min([lists:foldl(fun(N, Acc) -> abs(Target - N) + Acc end, 0, lists:sublist(Numbers, K)) || K <- lists:seq(1, length(Numbers))]);
        _ ->
            minimize_target_diff(Target, Numbers, 50, [])
    end.