-module(solution).
-export([reverse_pairs/1]).

-spec reverse_pairs([integer()]) -> integer().
reverse_pairs(Nums) ->
    {Count, _Sorted} = merge_sort(Nums),
    Count.

%% Merge Sort with Count of Reverse Pairs
merge_sort(Nums) ->
    merge_sort_helper(Nums, 0).

merge_sort_helper([], Count) -> {Count, []};
merge_sort_helper([X], Count) -> {Count, [X]};
merge_sort_helper([X, Y | Rest], Count) when X =< Y ->
    {NewCount, SortedRest} = merge_sort_helper([Y | Rest], Count),
    {NewCount, [X | SortedRest]};
merge_sort_helper([X, Y | Rest], Count) when X > Y ->
    {NewCount, SortedRest} = merge_sort_helper([Y | Rest], Count),
    {NewCount + 1, [X | SortedRest]}.

