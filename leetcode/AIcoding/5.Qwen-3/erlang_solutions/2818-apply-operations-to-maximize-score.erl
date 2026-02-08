-module(solution).
-export([maximumScore/1]).

maximumScore(Numbers) ->
    apply_operations(Numbers, []).

apply_operations([], Acc) ->
    lists:reverse(Acc);
apply_operations([N | T], Acc) ->
    case N of
        0 -> apply_operations(T, Acc);
        _ -> apply_operations(T, [N | Acc])
    end.