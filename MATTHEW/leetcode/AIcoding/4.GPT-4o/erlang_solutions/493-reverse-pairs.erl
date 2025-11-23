-module(solution).
-export([reverse_pairs/1]).

%% Main function to compute reverse pairs.
-spec reverse_pairs([integer()]) -> integer().
reverse_pairs(Nums) ->
    reverse_pairs(Nums, []).

%% Helper function to implement merge-sort and count reverse pairs.
-spec reverse_pairs([integer()], [integer()]) -> integer().
reverse_pairs([], Acc) ->
    length(Acc);
reverse_pairs([H|T], Acc) ->
    {Sorted, ReverseCount} = merge_sort_and_count([H|T], []),
    reverse_pairs(T, Acc ++ Sorted) + ReverseCount.

%% Merge-sort and count reverse pairs.
-spec merge_sort_and_count([integer()], [integer()]) -> {list(), integer()}.
merge_sort_and_count([], Acc) -> {Acc, 0};
merge_sort_and_count([X], Acc) -> {Acc ++ [X], 0};
merge_sort_and_count(List, Acc) ->
    {Left, Right} = lists:split(length(List) div 2, List),
    {SortedLeft, LeftCount} = merge_sort_and_count(Left, []),
    {SortedRight, RightCount} = merge_sort_and_count(Right, []),
    {Sorted, MergeCount} = merge_and_count(SortedLeft, SortedRight, 0),
    {Sorted, LeftCount + RightCount + MergeCount}.

%% Merge function that counts reverse pairs.
-spec merge_and_count([integer()], [integer()], integer()) -> {list(), integer()}.
merge_and_count([], [], Count) -> {[], Count};
merge_and_count(Left, [], Count) -> {Left, Count};
merge_and_count([], Right, Count) -> {Right, Count};
merge_and_count([L|Left], [R|Right], Count) when L > 2 * R ->
    merge_and_count([L|Left], Right, Count + length(R));
merge_and_count([L|Left], [R|Right], Count) ->
    case L > R of
        true -> merge_and_count(Left, [R|Right], Count);
        false -> merge_and_count([L|Left], Right, Count)
    end.
