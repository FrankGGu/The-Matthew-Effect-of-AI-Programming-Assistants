-module(binary_search).
-export([search/2]).

search(List, Target) ->
    search(List, Target, 0, length(List) - 1).

search(_, _, Left, Right) when Left > Right ->
    -1;
search(List, Target, Left, Right) ->
    Mid = (Left + Right) div 2,
    Val = lists:nth(Mid + 1, List),
    if
        Val == Target ->
            Mid;
        Val < Target ->
            search(List, Target, Mid + 1, Right);
        true ->
            search(List, Target, Left, Mid - 1)
    end.