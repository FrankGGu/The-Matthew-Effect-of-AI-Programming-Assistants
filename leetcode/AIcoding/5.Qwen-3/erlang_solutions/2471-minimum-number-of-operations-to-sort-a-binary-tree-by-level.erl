-module(solution).
-export([min_operations/1]).

min_operations(Root) ->
    Levels = get_levels(Root),
    lists:foldl(fun(LevelsList, Acc) -> 
        Sorted = lists:sort(LevelsList),
        Count = count_swaps(LevelsList, Sorted),
        Acc + Count
    end, 0, Levels).

get_levels(nil) ->
    [];
get_levels({val, Val, Left, Right}) ->
    [Val] ++ get_levels(Left) ++ get_levels(Right).

count_swaps(List, Sorted) ->
    IndexMap = maps:from_list([{Val, I} || {I, Val} <- lists:enumerate(Sorted)]),
    count_swaps(List, Sorted, IndexMap, 0, 0).

count_swaps([], _, _, _, Acc) ->
    Acc;
count_swaps([H | T], Sorted, IndexMap, Index, Acc) ->
    case H of
        Val when Val == lists:nth(Index + 1, Sorted) ->
            count_swaps(T, Sorted, IndexMap, Index + 1, Acc);
        _ ->
            TargetIndex = maps:get(H, IndexMap),
            count_swaps(lists:sublist(T, 1, TargetIndex - Index - 1) ++ [H | lists:sublist(T, TargetIndex - Index)], Sorted, IndexMap, Index + 1, Acc + 1)
    end.