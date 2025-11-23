-module(solution).
-export([partition_labels/1]).

partition_labels(S) ->
    LastIndex = maps:from_list([{C, I} || {I, C} <- lists:zip(lists:seq(0, length(S) - 1), string:to_list(S))]),
    partition_labels(S, LastIndex, 0, 0, []).

partition_labels([], _, _, _, Acc) -> lists:reverse(Acc);
partition_labels(S, LastIndex, Start, End, Acc) ->
    Char = lists:nth(Start + 1, string:to_list(S)),
    End = max(End, maps:get(Char, LastIndex)),
    case Start of
        End -> 
            partition_labels(S, LastIndex, Start + 1, 0, [End + 1 - Start | Acc]);
        _ -> 
            partition_labels(S, LastIndex, Start + 1, End, Acc)
    end.