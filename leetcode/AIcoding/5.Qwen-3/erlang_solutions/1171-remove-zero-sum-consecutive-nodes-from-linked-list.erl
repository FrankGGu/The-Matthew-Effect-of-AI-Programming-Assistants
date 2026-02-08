-module(remove_zero_sum_consecutive_nodes).
-export([remove_zero_sum_subarrays/1]).

-record(list_node, {val, next}).

remove_zero_sum_subarrays(Head) ->
    % Create a dummy node to simplify edge cases
    Dummy = #list_node{val=0, next=Head},
    Map = maps:new(),
    Sum = 0,
    Current = Dummy,
    remove_zero_sum_subarrays_loop(Current, Sum, Map),
    Dummy#list_node.next.

remove_zero_sum_subarrays_loop(Node, Sum, Map) ->
    if
        Node == null ->
            ok;
        true ->
            Sum = Sum + Node#list_node.val,
            case maps:find(Sum, Map) of
                {ok, PrevNode} ->
                    % Remove nodes between PrevNode and current Node
                    Next = PrevNode#list_node.next,
                    while Next /= Node do
                        Next = Next#list_node.next
                    end,
                    % Update the map by removing keys from the previous node onwards
                    NewMap = maps:fold(
                        fun(K, V, Acc) ->
                            if
                                K > Sum -> Acc;
                                true -> maps:remove(K, Acc)
                            end
                        end,
                        Map,
                        Map
                    ),
                    remove_zero_sum_subarrays_loop(PrevNode, Sum, NewMap);
                error ->
                    maps:put(Sum, Node, Map),
                    remove_zero_sum_subarrays_loop(Node#list_node.next, Sum, Map)
            end
    end.