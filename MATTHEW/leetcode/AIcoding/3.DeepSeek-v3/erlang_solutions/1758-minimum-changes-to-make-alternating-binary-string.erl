-spec min_operations(S :: unicode:unicode_binary()) -> integer().
min_operations(S) ->
    Bin = binary_to_list(S),
    Count1 = count_changes(Bin, $0),
    Count2 = count_changes(Bin, $1),
    min(Count1, Count2).

count_changes([], _) -> 0;
count_changes([H | T], Expected) ->
    (if H =/= Expected -> 1; true -> 0 end) + count_changes(T, (Expected + 1) rem 2).