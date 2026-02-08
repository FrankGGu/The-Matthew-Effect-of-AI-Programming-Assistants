-spec postorder(Root :: #node{} | null) -> [integer()].
postorder(null) -> [];
postorder(Root) ->
    Children = Root#node.children,
    lists:foldl(fun(Child, Acc) -> Acc ++ postorder(Child) end, [], Children) ++ [Root#node.val].