-module(solution).
-export([has_cycle/1]).

-record(list_node, {val, next}).

has_cycle(undefined) -> false;
has_cycle(Node) ->
    has_cycle(Node, Node).

has_cycle(_, _) -> false;
has_cycle(Slow, Fast) ->
    case Fast of
        undefined -> false;
        _ ->
            case Fast#list_node.next of
                undefined -> false;
                _ ->
                    case Fast#list_node.next#list_node.next of
                        undefined -> false;
                        _ ->
                            case Slow of
                                Fast -> true;
                                _ -> has_cycle(Slow#list_node.next, Fast#list_node.next#list_node.next)
                            end
                    end
            end
    end.