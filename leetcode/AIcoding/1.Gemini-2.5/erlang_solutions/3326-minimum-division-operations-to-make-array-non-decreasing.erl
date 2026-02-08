-module(solution).
-export([minimum_operations/2]).

ceil_div(A, B) when A > 0 andalso B > 0 ->
    (A + B - 1) div B.

minimum_operations(Nums, K) ->
    {TotalOps, _} = lists:foldr(
        fun(CurrentNum, {AccOps, PrevVal}) ->
            if CurrentNum =< PrevVal ->
                {AccOps, CurrentNum};
            true ->
                OpsNeeded = count_ops_to_reduce(CurrentNum, PrevVal, K),
                NewCurrentNum = calculate_reduced_value(CurrentNum, OpsNeeded, K),
                {AccOps + OpsNeeded, NewCurrentNum}
            end
        end,
        {0, 1000000000 + 1},
        Nums
    ),
    TotalOps.

count_ops_to_reduce(Val, TargetVal, K) ->
    count_ops_iter(Val, TargetVal, K, 0).

count_ops_iter(Val, TargetVal, _K, Ops) when Val =< TargetVal ->
    Ops;
count_ops_iter(Val, TargetVal, K, Ops) ->
    NewVal = ceil_div(Val, K),
    count_ops_iter(NewVal, TargetVal, K, Ops + 1).

calculate_reduced_value(CurrentNum, Ops, K) ->
    calculate_reduced_value_iter(CurrentNum, Ops, K).

calculate_reduced_value_iter(Val, 0, _K) ->
    Val;
calculate_reduced_value_iter(Val, Ops, K) ->
    NewVal = ceil_div(Val, K),
    calculate_reduced_value_iter(NewVal, Ops - 1, K).