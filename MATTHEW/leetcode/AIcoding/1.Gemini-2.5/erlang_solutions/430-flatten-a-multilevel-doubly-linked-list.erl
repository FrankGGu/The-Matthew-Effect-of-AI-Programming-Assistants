-module(solution).
-export([flatten/1]).

flatten(Head) ->
    case Head of
        undefined ->
            undefined;
        _ ->
            flatten_recursive(Head),
            Head
    end.

flatten_recursive(CurrentNode) ->
    case CurrentNode of
        undefined ->
            undefined;
        _ ->
            case CurrentNode#node.child of
                undefined ->
                    case CurrentNode#node.next of
                        undefined ->
                            CurrentNode;
                        NextNode ->
                            flatten_recursive(NextNode)
                    end;
                ChildHead ->
                    OriginalNext = CurrentNode#node.next,

                    CurrentNode#node.next = ChildHead,
                    ChildHead#node.prev = CurrentNode,
                    CurrentNode#node.child = undefined,

                    ChildTail = flatten_recursive(ChildHead),

                    case OriginalNext of
                        undefined ->
                            ChildTail;
                        _ ->
                            ChildTail#node.next = OriginalNext,
                            OriginalNext#node.prev = ChildTail,
                            flatten_recursive(OriginalNext)
                    end
            end
    end.