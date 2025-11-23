-module(vertical_order).
-export([vertical_order/1]).

-record(node, {val, left, right}).

vertical_order(undefined) ->
    [];
vertical_order(Root) ->
    Map = maps:new(),
    Queue = queue:from_list([{Root, 0}]),
    MinCol = 0,
    MaxCol = 0,
    {Map1, MinCol1, MaxCol1} = traverse(Map, Queue, MinCol, MaxCol),
    lists:foldl(fun(Col, Acc) ->
        lists:append(Acc, maps:get(Col, Map1))
    end, [], lists:seq(MinCol1, MaxCol1)).

traverse(Map, Queue, MinCol, MaxCol) ->
    case queue:is_empty(Queue) of
        true ->
            {Map, MinCol, MaxCol};
        false ->
            [{Node, Col} | Rest] = queue:to_list(Queue),
            NewQueue = queue:from_list(Rest),
            Val = Node#node.val,
            NewMap = maps:update_with(Col, fun(Values) -> [Val | Values] end, [Val], Map),
            NewMinCol = min(MinCol, Col),
            NewMaxCol = max(MaxCol, Col),
            Children = [],
            if
                Node#node.left /= undefined ->
                    NewQueue1 = queue:in({Node#node.left, Col - 1}, NewQueue),
                    Children = [Node#node.left];
                true ->
                    NewQueue1 = NewQueue
            end,
            if
                Node#node.right /= undefined ->
                    NewQueue2 = queue:in({Node#node.right, Col + 1}, NewQueue1),
                    Children = [Node#node.right | Children];
                true ->
                    NewQueue2 = NewQueue1
            end,
            traverse(NewMap, NewQueue2, NewMinCol, NewMaxCol)
    end.