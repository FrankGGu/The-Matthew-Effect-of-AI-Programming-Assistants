-module(flatten_multilevel_doubly_linked_list).
-export([flatten/1]).

-record(Node, {val, prev, next, child}).

flatten(undefined) ->
    undefined;
flatten(Node) ->
    flatten(Node, undefined).

flatten(#Node{next = Next, child = Child}, Prev) ->
    case Child of
        undefined ->
            case Next of
                undefined ->
                    Node#Node{prev = Prev, next = undefined};
                _ ->
                    Node#Node{prev = Prev, next = flatten(Next, Node)}
            end;
        _ ->
            ChildFlattened = flatten(Child, Node),
            NextFlattened = case Next of
                                undefined -> undefined;
                                _ -> flatten(Next, ChildFlattened)
                            end,
            Node#Node{prev = Prev, next = ChildFlattened, child = undefined},
            ChildFlattened#Node{prev = Node, next = NextFlattened}
    end.