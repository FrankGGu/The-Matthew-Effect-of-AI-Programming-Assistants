-spec count_days(Days :: integer(), Meetings :: [[integer()]]) -> integer().
count_days(Days, Meetings) ->
    Sorted = lists:sort(fun([A, _], [B, _]) -> A =< B end, Meetings),
    Merged = merge(Sorted),
    Total = lists:foldl(fun([S, E], Acc) -> Acc + (E - S + 1) end, 0, Merged),
    Days - Total.

merge([]) -> [];
merge([H | T]) -> merge(T, [H]).

merge([], Acc) -> lists:reverse(Acc);
merge([[S1, E1] | T], [[S2, E2] | Acc]) when E1 >= S2 - 1 ->
    merge(T, [[min(S1, S2), max(E1, E2)] | Acc]);
merge([H | T], Acc) ->
    merge(T, [H | Acc]).