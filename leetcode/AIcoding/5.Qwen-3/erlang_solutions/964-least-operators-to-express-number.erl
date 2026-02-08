-module(solution).
-export([least_ops_to_express_number/2]).

least_ops_to_express_number(Target, N) ->
    least_ops_to_express_number(Target, N, 0, 0).

least_ops_to_express_number(Target, N, Current, Ops) when Current >= Target ->
    if
        Current == Target -> Ops;
        true -> infinity
    end;

least_ops_to_express_number(Target, N, Current, Ops) ->
    case Current of
        0 -> least_ops_to_express_number(Target, N, N, 1);
        _ ->
            Min1 = least_ops_to_express_number(Target, N, Current * N, Ops + 1),
            Min2 = least_ops_to_express_number(Target, N, Current + 1, Ops + 1),
            min(Min1, Min2)
    end.