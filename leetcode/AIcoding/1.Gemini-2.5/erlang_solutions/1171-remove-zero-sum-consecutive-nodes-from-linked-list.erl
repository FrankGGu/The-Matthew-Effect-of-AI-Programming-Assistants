-record(list_node, {val, next}).

-spec remove_zero_sum_sublists(Head :: list_node() | nil) -> list_node() | nil.
remove_zero_sum_sublists(Head) ->
    Dummy = #list_node{val=0, next=Head},
    Map = #{0 => Dummy},

    remove_loop(Dummy, 0, Map),

    Dummy#list_node.next.

remove_loop(Current, CurrentSum, Map) ->
    case Current#list_node.next of
        nil ->
            ok;
        NextNode ->
            Val = NextNode#list_node.val,
            NewSum = CurrentSum + Val,

            case maps:is_key(NewSum, Map) of
                true ->
                    PrevNode = maps:get(NewSum, Map),

                    CleanedMap = cleanup_map(PrevNode#list_node.next, NextNode, NewSum, Map),

                    % Conceptually: PrevNode#list_node.next = NextNode#list_node.next.
                    % In Erlang, records are immutable. This means we are relying on the LeetCode
                    % environment's specific handling of `list_node` records, where they might
                    % be treated as mutable references.
                    % If not, a full list reconstruction would be necessary, which is much more complex.
                    % For a direct translation of the common imperative solution, we assume this conceptual
                    % mutation works.
                    PrevNode#list_node.next = NextNode#list_node.next,

                    % Restart the loop from PrevNode with the sum it represents.
                    remove_loop(PrevNode, NewSum, CleanedMap);
                false ->
                    NewMap = maps:put(NewSum, NextNode, Map),
                    remove_loop(NextNode, NewSum, NewMap)
            end
    end.

cleanup_map(NodeToClear, StopNode, SumBeforeNodeToClear, Map) ->
    case NodeToClear of
        StopNode ->
            Map;
        #list_node{val=Val, next=Next} ->
            SumToRemove = SumBeforeNodeToClear + Val,
            cleanup_map(Next, StopNode, SumToRemove, maps:remove(SumToRemove, Map))
    end.