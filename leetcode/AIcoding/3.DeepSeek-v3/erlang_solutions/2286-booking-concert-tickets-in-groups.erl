-module(book_concert_tickets).
-export([init/2, gather/3, scatter/3]).

-record(segment, {left, right, max, total}).

init(N, M) ->
    Tree = build_tree(0, N - 1, M),
    {N, M, Tree}.

build_tree(Left, Right, M) when Left =:= Right ->
    #segment{left = Left, right = Right, max = M, total = M};
build_tree(Left, Right, M) ->
    Mid = (Left + Right) div 2,
    LeftChild = build_tree(Left, Mid, M),
    RightChild = build_tree(Mid + 1, Right, M),
    #segment{
        left = Left,
        right = Right,
        max = max(LeftChild#segment.max, RightChild#segment.max),
        total = LeftChild#segment.total + RightChild#segment.total
    }.

gather(K, MaxRow, {N, M, Tree}) ->
    case query_gather(0, N - 1, K, MaxRow, Tree) of
        {ok, Row, Col} -> [Row, Col];
        [] -> []
    end.

query_gather(Left, Right, K, MaxRow, Node) when Node#segment.left =:= Left, Node#segment.right =:= Right ->
    if
        Left > MaxRow -> [];
        Node#segment.max < K -> [];
        true ->
            if
                Left =:= Right ->
                    {ok, Left, M - Node#segment.total};
                true ->
                    LeftChild = get_child(Node, left),
                    case query_gather(Left, LeftChild#segment.right, K, MaxRow, LeftChild) of
                        [] ->
                            RightChild = get_child(Node, right),
                            query_gather(RightChild#segment.left, Right, K, MaxRow, RightChild);
                        Result -> Result
                    end
            end
    end;
query_gather(Left, Right, K, MaxRow, Node) ->
    LeftChild = get_child(Node, left),
    RightChild = get_child(Node, right),
    if
        Right <= LeftChild#segment.right ->
            query_gather(Left, Right, K, MaxRow, LeftChild);
        Left >= RightChild#segment.left ->
            query_gather(Left, Right, K, MaxRow, RightChild);
        true ->
            case query_gather(Left, LeftChild#segment.right, K, MaxRow, LeftChild) of
                [] -> query_gather(RightChild#segment.left, Right, K, MaxRow, RightChild);
                Result -> Result
            end
    end.

scatter(K, MaxRow, {N, M, Tree}) ->
    case query_scatter(0, N - 1, K, MaxRow, Tree) of
        true -> true;
        false -> false
    end.

query_scatter(Left, Right, K, MaxRow, Node) when Node#segment.left =:= Left, Node#segment.right =:= Right ->
    if
        Left > MaxRow -> false;
        Node#segment.total < K -> false;
        true ->
            if
                Left =:= Right ->
                    update(Node, K),
                    true;
                true ->
                    LeftChild = get_child(Node, left),
                    case query_scatter(Left, LeftChild#segment.right, K, MaxRow, LeftChild) of
                        true ->
                            update(Node, K),
                            true;
                        false ->
                            RightChild = get_child(Node, right),
                            case query_scatter(RightChild#segment.left, Right, K, MaxRow, RightChild) of
                                true ->
                                    update(Node, K),
                                    true;
                                false -> false
                            end
                    end
            end
    end;
query_scatter(Left, Right, K, MaxRow, Node) ->
    LeftChild = get_child(Node, left),
    RightChild = get_child(Node, right),
    if
        Right <= LeftChild#segment.right ->
            query_scatter(Left, Right, K, MaxRow, LeftChild);
        Left >= RightChild#segment.left ->
            query_scatter(Left, Right, K, MaxRow, RightChild);
        true ->
            case query_scatter(Left, LeftChild#segment.right, K, MaxRow, LeftChild) of
                true ->
                    update(Node, K),
                    true;
                false ->
                    case query_scatter(RightChild#segment.left, Right, K, MaxRow, RightChild) of
                        true ->
                            update(Node, K),
                            true;
                        false -> false
                    end
            end
    end.

get_child(Node, left) ->
    #segment{left = Node#segment.left, right = (Node#segment.left + Node#segment.right) div 2};
get_child(Node, right) ->
    #segment{left = (Node#segment.left + Node#segment.right) div 2 + 1, right = Node#segment.right}.

update(Node, K) ->
    Node#segment{max = Node#segment.max - K, total = Node#segment.total - K}.