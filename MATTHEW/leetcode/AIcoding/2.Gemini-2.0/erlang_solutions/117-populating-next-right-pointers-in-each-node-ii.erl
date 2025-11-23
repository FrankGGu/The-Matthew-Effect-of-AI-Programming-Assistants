-module(solution).
-export([connect/1]).

-record(node, {val, left, right, next}).

connect(Root) ->
    connect_helper(Root).

connect_helper(Root) ->
    case Root of
        null ->
            null;
        _ ->
            connect_level(Root),
            Root
    end.

connect_level(Root) ->
    Head = get_next_level_head(Root),
    connect_next_level(Head).

connect_next_level(Head) ->
    case Head of
        null ->
            ok;
        _ ->
            NextHead = get_next_level_head(Head),
            connect_nodes(Head),
            connect_next_level(NextHead)
    end.

connect_nodes(Head) ->
    case Head of
        null ->
            ok;
        _ ->
            Next = get_next_node(Head),
            Head#node.next = Next,
            connect_nodes(get_next_node_in_level(Head))
    end.

get_next_node(Head) ->
    case Head of
        null ->
            null;
        _ ->
            case Head#node.left of
                null ->
                    case Head#node.right of
                        null ->
                            get_next_available_child(Head#node.next);
                        _ ->
                            Head#node.right
                    end;
                _ ->
                    Head#node.left
            end
    end.

get_next_available_child(Node) ->
    case Node of
        null ->
            null;
        _ ->
            case Node#node.left of
                null ->
                    case Node#node.right of
                        null ->
                            get_next_available_child(Node#node.next);
                        _ ->
                            Node#node.right
                    end;
                _ ->
                    Node#node.left
            end
    end.

get_next_node_in_level(Node) ->
    case Node of
        null ->
            null;
        _ ->
            Node#node.next
    end.

get_next_level_head(Root) ->
    case Root of
        null ->
            null;
        _ ->
            case Root#node.left of
                null ->
                    case Root#node.right of
                        null ->
                            get_next_available_level_head(Root#node.next);
                        _ ->
                            Root#node.right
                    end;
                _ ->
                    Root#node.left
            end
    end.

get_next_available_level_head(Node) ->
    case Node of
        null ->
            null;
        _ ->
            case Node#node.left of
                null ->
                    case Node#node.right of
                        null ->
                            get_next_available_level_head(Node#node.next);
                        _ ->
                            Node#node.right
                    end;
                _ ->
                    Node#node.left
            end
    end.