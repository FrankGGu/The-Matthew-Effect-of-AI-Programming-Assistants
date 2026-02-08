-module(n_ary_tree_level_order_traversal).
-export([level_order/1]).

-include_lib("stdlib/include/ms_transform.hrl").

-record(node, {val, children}).

level_order(undefined) ->
    [];
level_order(Root) ->
    Queue = queue:from_list([Root]),
    level_order(Queue, []).

level_order(Queue, Acc) ->
    case queue:out(Queue) of
        {empty, _} ->
            lists:reverse(Acc);
        {{value, Node}, NewQueue} ->
            Level = [Node#node.val],
            Children = Node#node.children,
            NextQueue = lists:foldl(fun(Child, Q) -> queue:in(Child, Q) end, NewQueue, Children),
            level_order(NextQueue, [Level | Acc])
    end.