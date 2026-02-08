-spec num_color(Root :: #tree_node{} | null) -> integer().
num_color(null) -> 0;
num_color(Root) ->
    Colors = sets:new(),
    Traverse = fun Traverse(Node, Acc) when Node =:= null -> Acc;
                  Traverse(Node, Acc) ->
                      NewAcc = sets:add_element(Node#tree_node.val, Acc),
                      LeftAcc = Traverse(Node#tree_node.left, NewAcc),
                      Traverse(Node#tree_node.right, LeftAcc)
              end,
    sets:size(Traverse(Root, Colors)).