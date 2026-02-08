-module(solution).
-export([level_order/1]).

level_order(undefined) -> [];
level_order(Root) ->
    Queue = queue:from_list([Root]),
    Result = [],
    level_order(Queue, Result).

level_order(Queue, Result) ->
    case queue:is_empty(Queue) of
        true -> Result;
        false ->
            LevelSize = queue:len(Queue),
            Level = collect_level(Queue, LevelSize, []),
            Result2 = Result ++ [Level],
            NewQueue = add_children(Queue, LevelSize, queue:new()),
            level_order(NewQueue, Result2)
    end.

collect_level(_, 0, Acc) -> lists:reverse(Acc);
collect_level(Queue, N, Acc) ->
    {value, Node} = queue:out(Queue),
    Value = node_value(Node),
    collect_level(Queue, N-1, [Value | Acc]).

add_children(_, 0, Acc) -> Acc;
add_children(Queue, N, Acc) ->
    {value, Node} = queue:out(Queue),
    Children = node_children(Node),
    NewAcc = add_children_to_queue(Children, Acc),
    add_children(Queue, N-1, NewAcc).

add_children_to_queue([], Acc) -> Acc;
add_children_to_queue([Child | Rest], Acc) ->
    add_children_to_queue(Rest, queue:in(Child, Acc)).

node_value({value, V, _}) -> V;
node_value(_) -> undefined.

node_children({_, _, C}) -> C;
node_children(_) -> [].