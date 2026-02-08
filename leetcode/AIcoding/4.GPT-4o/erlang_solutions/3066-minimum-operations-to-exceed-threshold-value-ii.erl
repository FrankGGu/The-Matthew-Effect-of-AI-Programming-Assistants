-module(solution).
-export([min_operations/2]).

min_operations(ops, threshold) ->
    MinOps = lists:map(fun(X) -> {X, 0} end, ops),
    MaxOps = lists:max(ops),
    ThresholdInt = threshold * 2,
    MinOps2 = lists:foldl(fun(Op, Acc) ->
        case lists:sum(Acc) >= ThresholdInt of
            true -> Acc;
            false -> [{Op + MaxOps, 1} | Acc]
        end
    end, [], MinOps),
    case lists:sum(MinOps2) >= ThresholdInt of
        true -> length(MinOps2);
        false -> -1
    end.