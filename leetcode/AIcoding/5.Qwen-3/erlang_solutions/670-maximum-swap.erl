-module(maximum_swap).
-export([maximum_swap/1]).

maximum_swap(N) ->
    List = integer_to_list(N),
    Len = length(List),
    MaxIndex = find_max_index(List, 0, 0),
    if
        MaxIndex == 0 -> N;
        true ->
            Swap(List, 0, MaxIndex)
    end.

find_max_index(_, Index, MaxIndex) when Index == length([]) -> MaxIndex;
find_max_index(List, Index, MaxIndex) ->
    Current = lists:nth(Index + 1, List),
    MaxVal = lists:nth(MaxIndex + 1, List),
    if
        Current > MaxVal -> find_max_index(List, Index + 1, Index);
        true -> find_max_index(List, Index + 1, MaxIndex)
    end.

Swap(List, I, J) ->
    A = lists:sublist(List, I + 1),
    B = lists:sublist(List, J + 1, length(List) - J - 1),
    C = lists:sublist(List, J + 1),
    D = lists:sublist(List, I + 1, length(List) - I - 1),
    NewList = A ++ [lists:nth(J + 1, List)] ++ B ++ [lists:nth(I + 1, List)] ++ D,
    list_to_integer(NewList).