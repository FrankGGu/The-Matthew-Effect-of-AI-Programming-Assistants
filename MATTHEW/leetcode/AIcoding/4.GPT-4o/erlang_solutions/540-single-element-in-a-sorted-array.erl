-module(solution).
-export([single_non_duplicate/1]).

single_non_duplicate(List) ->
    binary_search(List, 0, length(List) - 1).

binary_search(List, Left, Right) when Left < Right ->
    Mid = (Left + Right) div 2,
    IfEven = (Mid rem 2) == 0,
    NewMid = if IfEven -> Mid; true -> Mid - 1 end,
    if lists:nth(NewMid + 1, List) == lists:nth(NewMid + 1, List) ->
        binary_search(List, Mid + 1, Right);
    true ->
        binary_search(List, Left, Mid)
    end;
binary_search(List, Left, Right) ->
    lists:nth(Left + 1, List).