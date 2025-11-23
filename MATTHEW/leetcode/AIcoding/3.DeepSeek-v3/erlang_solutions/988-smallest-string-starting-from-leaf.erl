-spec smallest_from_leaf(Root :: #tree_node{} | null) -> unicode:unicode_binary().
smallest_from_leaf(null) -> <<>>;
smallest_from_leaf(Root) ->
    Paths = collect_paths(Root, []),
    Smallest = find_smallest(Paths, []),
    list_to_binary(Smallest).

collect_paths(null, _) -> [];
collect_paths(#tree_node{val = Val, left = null, right = null}, Path) ->
    [[Val + $a | Path]];
collect_paths(#tree_node{val = Val, left = Left, right = Right}, Path) ->
    NewPath = [Val + $a | Path],
    collect_paths(Left, NewPath) ++ collect_paths(Right, NewPath).

find_smallest([], Smallest) -> Smallest;
find_smallest([Path | Rest], []) -> find_smallest(Rest, Path);
find_smallest([Path | Rest], Smallest) ->
    case compare_paths(Path, Smallest) of
        smaller -> find_smallest(Rest, Path);
        _ -> find_smallest(Rest, Smallest)
    end.

compare_paths([], []) -> equal;
compare_paths([], _) -> smaller;
compare_paths(_, []) -> larger;
compare_paths([X | Xs], [Y | Ys]) when X < Y -> smaller;
compare_paths([X | Xs], [Y | Ys]) when X > Y -> larger;
compare_paths([_ | Xs], [_ | Ys]) -> compare_paths(Xs, Ys).