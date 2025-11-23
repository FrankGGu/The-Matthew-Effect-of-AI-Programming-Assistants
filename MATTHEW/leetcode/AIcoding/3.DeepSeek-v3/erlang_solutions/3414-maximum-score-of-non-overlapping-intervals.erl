-module(solution).
-export([max_score/1]).

max_score(Intervals) ->
    Sorted = lists:sort(fun([_, A], [_, B]) -> A =< B end, Intervals),
    DP = lists:foldl(fun([S, E], Acc) ->
        case lists:search(fun([_, LastE]) -> LastE =< S end, Acc) of
            {value, [Sum, _]} -> [[Sum + E - S, E] | Acc];
            false -> [[E - S, E] | Acc]
        end
    end, [], Sorted),
    case DP of
        [] -> 0;
        _ -> lists:max(lists:map(fun([Sum, _]) -> Sum end, DP))
    end.