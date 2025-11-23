-module(solution).
-export([remove_zero_sum_slices/1]).

-record(node, {val, next}).

remove_zero_sum_slices(List) ->
    {Ok, Head} = build_list(List),
    ResultHead = remove_zero_sum(Head, #{}),
    list_to_array(ResultHead).

build_list([]) -> {ok, null};
build_list([H|T]) ->
    {Ok, Next} = build_list(T),
    Node = #node{val = H, next = Next},
    {ok, Node}.

remove_zero_sum(Head, SumMap) ->
    remove_zero_sum(Head, 0, SumMap).

remove_zero_sum(null, _, _) -> null;
remove_zero_sum(Node, CurrentSum, SumMap) ->
    NewSum = CurrentSum + Node#node.val,
    case maps:is_key(NewSum, SumMap) of
        true ->
            {Ok, NewHead} = remove_to_zero(Node, NewSum, SumMap),
            NewHead;
        false ->
            NewMap = maps:put(CurrentSum, Node, SumMap),
            NextNode = remove_zero_sum(Node#node.next, NewSum, NewMap),
            Node#node{next = NextNode}
    end.

remove_to_zero(Node, Sum, SumMap) ->
    NewSum = Node#node.val,
    case maps:is_key(NewSum, SumMap) of
        true ->
            NextNode = SumMap[NewSum],
            remove_to_zero(NextNode, Sum, maps:remove(NewSum, SumMap));
        false ->
            Node
    end.

list_to_array(null) -> [];
list_to_array(Node) -> [Node#node.val | list_to_array(Node#node.next)].