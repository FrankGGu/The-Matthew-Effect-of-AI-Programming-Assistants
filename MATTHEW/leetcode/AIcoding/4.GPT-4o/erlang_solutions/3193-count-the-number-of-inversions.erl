-module(count_inversions).
-export([count_inversions/1]).

count_inversions(List) ->
    {Inversions, _SortedList} = merge_sort(List),
    Inversions.

merge_sort(List) ->
    case length(List) of
        0 -> {0, []};
        1 -> {0, List};
        _ ->
            {LeftInv, Left} = merge_sort(lists:sublist(List, 1, length(List) div 2)),
            {RightInv, Right} = merge_sort(lists:sublist(List, length(List) div 2 + 1)),
            {MergeInv, Merged} = merge(Left, Right),
            {LeftInv + RightInv + MergeInv, Merged}
    end.

merge([], Right) -> {0, Right};
merge(Left, []) -> {0, Left};
merge([H1 | T1] = Left, [H2 | T2] = Right) ->
    if
        H1 =< H2 ->
            {Inv, Merged} = merge(T1, Right),
            {Inv, [H1 | Merged]};
        true ->
            {Inv, Merged} = merge(Left, T2),
            {Inv + length(Left), [H2 | Merged]}
    end.