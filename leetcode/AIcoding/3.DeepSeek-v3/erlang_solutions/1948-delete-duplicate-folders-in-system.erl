-module(delete_duplicate_folders).
-export([deleteDuplicateFolder/1]).

deleteDuplicateFolder(Paths) ->
    Tree = build_tree(Paths),
    {NewTree, _} = mark_duplicates(Tree, #{}),
    collect_paths(NewTree).

build_tree(Paths) ->
    Root = #{name => <<>>, children => #{}},
    lists:foldl(fun(Path, Acc) -> add_path(Path, Acc) end, Root, Paths).

add_path([], Node) -> Node;
add_path([H | T], Node) ->
    Children = maps:get(children, Node),
    case maps:get(H, Children, undefined) of
        undefined ->
            NewChild = #{name => H, children => #{}},
            NewChildren = maps:put(H, NewChild, Children),
            add_path(T, Node#{children => NewChildren});
        Child ->
            add_path(T, Child)
    end.

mark_duplicates(Node, Seen) ->
    Children = maps:get(children, Node),
    {NewChildren, NewSeen} = 
        maps:fold(fun(_, Child, {AccChildren, AccSeen}) ->
            {NewChild, UpdatedSeen} = mark_duplicates(Child, AccSeen),
            Key = serialize(NewChild),
            case maps:get(Key, UpdatedSeen, undefined) of
                undefined ->
                    {maps:put(serialize(NewChild), NewChild, AccChildren), maps:put(Key, NewChild, UpdatedSeen)};
                Existing ->
                    {maps:put(serialize(NewChild), Existing#{marked => true}, AccChildren), UpdatedSeen}
            end
        end, {#{}, Seen}, Children),
    NewNode = Node#{children => NewChildren},
    case maps:get(marked, NewNode, false) of
        true -> {NewNode#{marked => true}, NewSeen};
        false -> {NewNode, NewSeen}
    end.

serialize(Node) ->
    Children = maps:get(children, Node),
    if 
        map_size(Children) == 0 -> <<>>;
        true ->
            lists:foldl(fun({Name, Child}, Acc) ->
                <<Acc/binary, Name/binary, "(", (serialize(Child))/binary, ")">>
            end, <<>>, lists:sort(maps:to_list(Children)))
    end.

collect_paths(Node) ->
    collect_paths(Node, [], []).

collect_paths(Node, CurrentPath, Acc) ->
    Name = maps:get(name, Node),
    Children = maps:get(children, Node),
    NewPath = if Name == <<>> -> CurrentPath; true -> CurrentPath ++ [Name] end,
    case maps:get(marked, Node, false) of
        true -> Acc;
        false ->
            NewAcc = if map_size(Children) == 0 -> [NewPath | Acc]; true -> Acc end,
            maps:fold(fun(_, Child, AccIn) ->
                collect_paths(Child, NewPath, AccIn)
            end, NewAcc, Children)
    end.