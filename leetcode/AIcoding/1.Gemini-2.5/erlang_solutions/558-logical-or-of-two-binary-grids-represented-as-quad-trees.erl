-record(node, {val :: boolean(), isLeaf :: boolean(),
               topLeft :: #node{} | nil, topRight :: #node{} | nil,
               bottomLeft :: #node{} | nil, bottomRight :: #node{} | nil}).

quadTree_intersect(Node1, Node2) ->
    if Node1#node.isLeaf andalso Node1#node.val ->
        #node{val = true, isLeaf = true, topLeft = nil, topRight = nil, bottomLeft = nil, bottomRight = nil};
    Node2#node.isLeaf andalso Node2#node.val ->
        #node{val = true, isLeaf = true, topLeft = nil, topRight = nil, bottomLeft = nil, bottomRight = nil};
    Node1#node.isLeaf andalso not Node1#node.val ->
        Node2;
    Node2#node.isLeaf andalso not Node2#node.val ->
        Node1;
    true ->
        NewTopLeft = quadTree_intersect(Node1#node.topLeft, Node2#node.topLeft),
        NewTopRight = quadTree_intersect(Node1#node.topRight, Node2#node.topRight),
        NewBottomLeft = quadTree_intersect(Node1#node.bottomLeft, Node2#node.bottomLeft),
        NewBottomRight = quadTree_intersect(Node1#node.bottomRight, Node2#node.bottomRight),

        if NewTopLeft#node.isLeaf andalso NewTopRight#node.isLeaf andalso
           NewBottomLeft#node.isLeaf andalso NewBottomRight#node.isLeaf andalso
           NewTopLeft#node.val =:= NewTopRight#node.val andalso
           NewTopLeft#node.val =:= NewBottomLeft#node.val andalso
           NewTopLeft#node.val =:= NewBottomRight#node.val ->
            #node{val = NewTopLeft#node.val, isLeaf = true, topLeft = nil, topRight = nil, bottomLeft = nil, bottomRight = nil};
        true ->
            #node{val = false, isLeaf = false,
                  topLeft = NewTopLeft, topRight = NewTopRight,
                  bottomLeft = NewBottomLeft, bottomRight = NewBottomRight}
        end
    end.