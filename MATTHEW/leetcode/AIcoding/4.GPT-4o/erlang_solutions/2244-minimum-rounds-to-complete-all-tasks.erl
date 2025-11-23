-module(solution).
-export([minimumRounds/1]).

minimumRounds(Tasks) ->
    Counts = maps:from_list(lists:map(fun(X) -> {X, 1} end, Tasks)),
    TotalRounds = lists:foldl(fun({Task, Count}, Acc) ->
        case Count of
            1 -> -1; % If there's a task with only one occurrence, return -1
            _ -> Acc + ceil(Count / 3)
        end
    end, 0, maps:to_list(Counts)),
    case TotalRounds of
        -1 -> -1;
        _ -> TotalRounds
    end.