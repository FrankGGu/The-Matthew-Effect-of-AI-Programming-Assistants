-spec remove_zero_sum_sublists(Head :: #list_node{} | null) -> #list_node{} | null.
remove_zero_sum_sublists(Head) ->
    Dummy = #list_node{val = 0, next = Head},
    PrefixSumMap = #{0 => Dummy},
    PrefixSum = 0,
    Current = Head,
    {NewPrefixSumMap, NewCurrent} = build_prefix_sum_map(Current, PrefixSum, PrefixSumMap),
    {_, NewHead} = rebuild_list(Dummy, NewPrefixSumMap),
    NewHead#list_node.next.

build_prefix_sum_map(Current, PrefixSum, PrefixSumMap) ->
    case Current of
        null -> {PrefixSumMap, Current};
        #list_node{val = Val, next = Next} ->
            NewPrefixSum = PrefixSum + Val,
            case maps:is_key(NewPrefixSum, PrefixSumMap) of
                true ->
                    Node = maps:get(NewPrefixSum, PrefixSumMap),
                    Node#list_node.next = Current#list_node.next,
                    NewPrefixSumMap = maps:remove(NewPrefixSum, PrefixSumMap),
                    build_prefix_sum_map(Current#list_node.next, NewPrefixSum, NewPrefixSumMap);
                false ->
                    NewPrefixSumMap = maps:put(NewPrefixSum, Current, PrefixSumMap),
                    build_prefix_sum_map(Next, NewPrefixSum, NewPrefixSumMap)
            end
    end.

rebuild_list(Current, PrefixSumMap) ->
    case Current of
        null -> {PrefixSumMap, null};
        #list_node{next = Next} = Node ->
            {NewPrefixSumMap, NewNext} = rebuild_list(Next, PrefixSumMap),
            Node#list_node.next = NewNext,
            {NewPrefixSumMap, Node}
    end.