-module(solution).
-export([count_inversions/1]).

count_inversions(List) ->
    {_, Count} = merge_sort(List),
    Count.

merge_sort([]) -> {[], 0};
merge_sort([X]) -> { [X], 0 };
merge_sort(List) ->
    Len = length(List),
    Mid = Len div 2,
    {Left, LeftCount} = merge_sort(lists:split(Mid, List)),
    {Right, RightCount} = merge_sort(lists:split(Mid, List)),
    {Merged, SplitCount} = merge(Left, Right),
    {Merged, LeftCount + RightCount + SplitCount}.

merge([], Right) -> {Right, 0};
merge(Left, []) -> {Left, 0};
merge([L | Ls], [R | Rs]) when L =< R ->
    { [L | Merged], Count } = merge(Ls, [R | Rs]),
    { [L | Merged], Count };
merge([L | Ls], [R | Rs]) ->
    { [R | Merged], Count } = merge([L | Ls], Rs),
    { [R | Merged], Count + length(Ls) + 1 }.