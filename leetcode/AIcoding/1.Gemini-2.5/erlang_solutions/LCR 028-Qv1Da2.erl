-record(node, {val, prev, next, child}).

-export([flatten/1]).

flatten(Head) ->
    case Head of
        nil -> nil;
        _ ->
            flatten_loop(Head),
            Head
    end.

flatten_loop(Current) ->
    case Current of
        nil -> ok;
        _ ->
            case Current#node.child of
                nil ->
                    % No child, move to next
                    flatten_loop(Current#node.next);
                Child ->
                    % Has child.
                    % 1. Save Current's original next.
                    NextNode = Current#node.next,

                    % 2. Recursively flatten the child list.
                    % This call modifies the child list in-place.
                    flatten_loop(Child),

                    % 3. Find the tail of the flattened child list.
                    ChildTail = get_tail(Child),

                    % 4. Link Current -> Child
                    % These are the "in-place" modifications.
                    % Assuming record fields are mutable for LeetCode's Erlang environment.
                    Current#node.next = Child,
                    Child#node.prev = Current,
                    Current#node.child = nil, % Set child to null

                    % 5. Link ChildTail -> NextNode
                    case NextNode of
                        nil ->
                            ChildTail#node.next = nil;
                        _ ->
                            ChildTail#node.next = NextNode,
                            NextNode#node.prev = ChildTail
                    end,
                    % 6. Continue processing from NextNode (which is now linked after ChildTail)
                    flatten_loop(NextNode)
            end
    end.

get_tail(Node) ->
    get_tail_iter(Node).

get_tail_iter(Current) ->
    case Current#node.next of
        nil -> Current;
        Next -> get_tail_iter(Next)
    end.