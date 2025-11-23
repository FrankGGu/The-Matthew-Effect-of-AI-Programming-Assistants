-module(solution).
-export([alternatingGroups/1]).

alternatingGroups(List) ->
    Grouped = group(List, 0, []),
    lists:map(fun(X) -> lists:sum(X) end, Grouped).

group([], _, Acc) -> [lists:reverse(Acc)];
group([H | T], Dir, Acc) ->
    case Dir of
        0 -> group(T, 1, [H | Acc]);
        1 -> group(T, 0, [H | Acc]);
    end.