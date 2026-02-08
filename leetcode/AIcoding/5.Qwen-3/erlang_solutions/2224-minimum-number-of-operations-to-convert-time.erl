-module(min_operations).
-export([num_of_ops/2]).

num_of_ops(StartTime, TargetTime) ->
    [H1, M1] = string:split(StartTime, ":"),
    [H2, M2] = string:split(TargetTime, ":"),
    H1Int = list_to_integer(H1),
    M1Int = list_to_integer(M1),
    H2Int = list_to_integer(H2),
    M2Int = list_to_integer(M2),
    TotalMinutes1 = H1Int * 60 + M1Int,
    TotalMinutes2 = H2Int * 60 + M2Int,
    Diff = TotalMinutes2 - TotalMinutes1,
    if
        Diff < 0 -> Diff + 24 * 60;
        true -> Diff
    end.

num_of_ops(StartTime, TargetTime, Acc, Ops) ->
    case Ops of
        [] -> Acc;
        [Op | Rest] ->
            case Op of
                60 -> num_of_ops(StartTime, TargetTime, Acc + (Diff div 60), Rest);
                15 -> num_of_ops(StartTime, TargetTime, Acc + (Diff div 15), Rest);
                5 -> num_of_ops(StartTime, TargetTime, Acc + (Diff div 5), Rest);
                1 -> num_of_ops(StartTime, TargetTime, Acc + Diff, Rest)
            end
    end.

num_of_ops(StartTime, TargetTime) ->
    Diff = num_of_ops(StartTime, TargetTime),
    num_of_ops(StartTime, TargetTime, 0, [60, 15, 5, 1]).