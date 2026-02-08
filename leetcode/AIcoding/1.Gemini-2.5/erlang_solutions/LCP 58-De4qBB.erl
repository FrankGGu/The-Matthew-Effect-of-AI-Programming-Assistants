-module(solution).
-export([solve/1]).

solve(Blocks) ->
    case length(Blocks) of
        0 -> 0;
        1 -> 0;
        _ ->
            SortedBlocks = lists:sort(Blocks),
            merge_blocks(SortedBlocks, 0)
    end.

merge_blocks([_], TotalCost) ->
    TotalCost;
merge_blocks([A, B | Rest], CurrentTotalCost) ->
    NewBlockValue = A + B,
    NewTotalCost = CurrentTotalCost + NewBlockValue,
    NewSortedBlocks = insert_sorted(NewBlockValue, Rest),
    merge_blocks(NewSortedBlocks, NewTotalCost).

insert_sorted(Element, []) ->
    [Element];
insert_sorted(Element, [H | T]) when Element =< H ->
    [Element, H | T];
insert_sorted(Element, [H | T]) ->
    [H | insert_sorted(Element, T)].