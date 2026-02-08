-spec min_changes(BinString :: unicode:unicode_binary()) -> integer().
min_changes(BinString) ->
    Bin = binary_to_list(BinString),
    min_changes_helper(Bin, 0, 0).

min_changes_helper([], Count1, Count2) ->
    min(Count1, Count2);
min_changes_helper([H | T], Count1, Count2) when H == $0 ->
    min_changes_helper(T, Count2 + 1, Count1);
min_changes_helper([H | T], Count1, Count2) when H == $1 ->
    min_changes_helper(T, Count2, Count1 + 1).