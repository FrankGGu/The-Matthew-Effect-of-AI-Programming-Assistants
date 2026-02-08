-module(solution).
-export([level_order/1]).

%% 定义节点结构：#{val => integer(), children => [Node]}
-spec level_order(Root :: map() | 'null') -> [[integer()]].
level_order(null) ->
    [];
level_order(Root) ->
    level_order_queue([Root], []).

level_order_queue([], Acc) ->
    lists:reverse(Acc);
level_order_queue(Queue, Acc) ->
    {Values, NextLevel} = lists:foldl(
        fun(Node, {Vals, Next}) ->
            { [maps:get(val, Node) | Vals], lists:append(Next, maps:get(children, Node)) }
        end,
        {[], []},
        Queue
    ),
    level_order_queue(NextLevel, [lists:reverse(Values) | Acc]).
