-spec get_directions(Root :: #tree_node{} | null, StartValue :: integer(), DestValue :: integer()) -> unicode:unicode_binary().
get_directions(Root, StartValue, DestValue) ->
    {Path1, Path2} = find_paths(Root, StartValue, DestValue),
    common_prefix_length = find_common_prefix_length(Path1, Path2),
    UpSteps = length(Path1) - common_prefix_length,
    DownPath = lists:sublist(Path2, common_prefix_length + 1, length(Path2) - common_prefix_length),
    Result = lists:duplicate(UpSteps, $U) ++ DownPath,
    list_to_binary(Result).

find_paths(Root, StartValue, DestValue) ->
    Path1 = find_path(Root, StartValue, []),
    Path2 = find_path(Root, DestValue, []),
    {Path1, Path2}.

find_path(null, _, _) -> [];
find_path(Node, Value, Path) ->
    case Node#tree_node.val of
        Value -> Path;
        _ ->
            LeftPath = find_path(Node#tree_node.left, Value, Path ++ [$L]),
            case LeftPath of
                [] -> find_path(Node#tree_node.right, Value, Path ++ [$R]);
                _ -> LeftPath
            end
    end.

find_common_prefix_length(Path1, Path2) ->
    find_common_prefix_length(Path1, Path2, 0).

find_common_prefix_length([H|T1], [H|T2], Len) ->
    find_common_prefix_length(T1, T2, Len + 1);
find_common_prefix_length(_, _, Len) -> Len.