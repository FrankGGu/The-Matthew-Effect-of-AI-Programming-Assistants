-module(flatten_multilevel_doubly_linked_list).
-export([flatten/1]).

-record(Node, {val, prev, next, child}).

flatten(undefined) -> undefined;
flatten(Node) ->
    flatten(Node, undefined).

flatten(#Node{next = Next, child = Child}, Prev) ->
    case Child of
        undefined ->
            case Next of
                undefined ->
                    Node#Node{prev = Prev, next = undefined};
                _ ->
                    NewNext = flatten(Next, Node),
                    Node#Node{prev = Prev, next = NewNext}
            end;
        _ ->
            ChildFlattened = flatten(Child, Node),
            NextFlattened = flatten(Next, ChildFlattened),
            Node#Node{prev = Prev, next = ChildFlattened, child = undefined},
            NextFlattened
    end.