-module(linked_list_cycle_ii).
-export([detect_cycle/1]).

-record(list_node, {val, next}).

detect_cycle(undefined) -> undefined;
detect_cycle(Node) ->
    {HasCycle, Slow, Fast} = check_cycle(Node),
    if
        HasCycle ->
            {_, Slow2} = find_start(Slow, Node),
            Slow2;
        true ->
            undefined
    end.

check_cycle(Node) ->
    check_cycle(Node, Node).

check_cycle(Slow, Fast) ->
    case Fast of
        undefined -> {false, Slow, Fast};
        _ ->
            case Fast#list_node.next of
                undefined -> {false, Slow, Fast};
                _ ->
                    case Fast#list_node.next#list_node.next of
                        undefined -> {false, Slow, Fast};
                        _ ->
                            case Slow == Fast of
                                true -> {true, Slow, Fast};
                                false -> check_cycle(Slow#list_node.next, Fast#list_node.next#list_node.next)
                            end
                    end
            end
    end.

find_start(Slow, Fast) ->
    find_start(Slow, Fast, 0).

find_start(Slow, Fast, Count) ->
    case Slow == Fast of
        true -> {Count, Slow};
        false -> find_start(Slow#list_node.next, Fast#list_node.next, Count + 1)
    end.