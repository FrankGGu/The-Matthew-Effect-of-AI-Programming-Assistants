-module(solution).
-export([maximum_beautiful_items/2]).

maximum_beautiful_items(Items, Queries) ->
    SortedItems = lists:sort(fun([A, _], [B, _]) -> A =< B end, Items),
    MaxBeauty = lists:foldl(fun([_, B], Acc) -> [max(B, hd(Acc)) | Acc] end, [0], SortedItems),
    MaxBeautyList = lists:reverse(MaxBeauty),
    lists:map(fun(Q) -> 
        Index = binary_search(SortedItems, Q),
        if Index >= 0 -> lists:nth(Index + 1, MaxBeautyList);
           true -> 0
        end
    end, Queries).

binary_search(Items, Q) ->
    binary_search(Items, Q, 0, length(Items) - 1).

binary_search(Items, Q, Left, Right) when Left =< Right ->
    Mid = (Left + Right) div 2,
    [Val, _] = lists:nth(Mid + 1, Items),
    if Val =< Q -> binary_search(Items, Q, Mid + 1, Right);
       true -> binary_search(Items, Q, Left, Mid - 1)
    end;
binary_search(_, _, Left, _) -> Left - 1.