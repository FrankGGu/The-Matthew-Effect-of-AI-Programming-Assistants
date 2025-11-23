-spec can_be_sorted(Binary :: binary()) -> boolean().
can_be_sorted(Binary) ->
    List = binary_to_list(Binary),
    Sorted = lists:sort(List),
    can_be_sorted(List, Sorted, false).

can_be_sorted([], [], _) -> true;
can_be_sorted([H1|T1], [H2|T2], Swapped) when H1 =:= H2 ->
    can_be_sorted(T1, T2, Swapped);
can_be_sorted([H1|T1], [H2|T2], false) when H1 =/= H2 ->
    can_be_sorted(T1, T2, true);
can_be_sorted(_, _, _) -> false.