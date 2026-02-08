-module(pancake_sorting).
-export([sort_pancake/1]).

sort_pancake(List) ->
    sort_pancake(List, length(List)).

sort_pancake(_, 1) ->
    [];
sort_pancake(List, N) ->
    MaxIndex = find_max_index(List, N),
    if
        MaxIndex == N-1 ->
            sort_pancake(lists:sublist(List, N-1), N-1);
        true ->
            [FirstPart, SecondPart] = split_list(List, MaxIndex + 1),
            FirstReversed = lists:reverse(FirstPart),
            NewList = FirstReversed ++ SecondPart,
            [FirstPart2, SecondPart2] = split_list(NewList, N),
            FirstReversed2 = lists:reverse(FirstPart2),
            NewList2 = FirstReversed2 ++ SecondPart2,
            [MaxIndex+1 | [N | sort_pancake(NewList2, N-1)]]
    end.

find_max_index(List, N) ->
    find_max_index(List, N, 0, 0).

find_max_index([], _, _, MaxIndex) ->
    MaxIndex;
find_max_index([H|T], N, Index, MaxIndex) ->
    if
        H > lists:nth(MaxIndex + 1, List) ->
            find_max_index(T, N, Index + 1, Index);
        true ->
            find_max_index(T, N, Index + 1, MaxIndex)
    end.

split_list(List, N) ->
    {lists:sublist(List, N), lists:sublist(List, N+1, length(List) - N)}.