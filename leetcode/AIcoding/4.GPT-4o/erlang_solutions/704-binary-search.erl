-module(solution).
-export([search/2]).

search(List, Target) ->
    search(List, Target, 0, length(List) - 1).

search(_, Target, L, R) when L > R ->
    -1;
search(List, Target, L, R) ->
    Mid = (L + R) div 2,
    case lists:nth(Mid + 1, List) of
        Target -> Mid;
        V when V < Target -> search(List, Target, Mid + 1, R);
        _ -> search(List, Target, L, Mid - 1)
    end.