-spec min_swaps_couples(Row :: [integer()]) -> integer().
min_swaps_couples(Row) ->
    N = length(Row),
    Map = maps:from_list([{lists:nth(I, Row), I - 1} || I <- lists:seq(1, N)]),
    do_swaps(Row, Map, 0, 0).

do_swaps(Row, Map, I, Count) when I >= length(Row) ->
    Count;
do_swaps(Row, Map, I, Count) ->
    A = lists:nth(I + 1, Row),
    B = if A rem 2 == 0 -> A - 1; true -> A + 1 end,
    J = maps:get(B, Map),
    if
        J == I + 1 ->
            do_swaps(Row, Map, I + 2, Count);
        true ->
            C = lists:nth(I + 2, Row),
            NewRow = swap(Row, I + 1, I + 2),
            NewMap = maps:put(C, J, maps:put(B, I + 1, Map)),
            do_swaps(NewRow, NewMap, I + 2, Count + 1)
    end.

swap(List, I, J) ->
    E1 = lists:nth(I, List),
    E2 = lists:nth(J, List),
    lists:sublist(List, I - 1) ++ [E2] ++ lists:nthtail(I, lists:sublist(List, J - 1)) ++ [E1] ++ lists:nthtail(J, List).