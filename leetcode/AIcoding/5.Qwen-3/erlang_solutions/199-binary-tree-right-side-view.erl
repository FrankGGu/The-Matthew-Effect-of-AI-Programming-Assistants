-module(solution).
-export([right_side_view/1]).

right_side_view(nil) -> [];
right_side_view(Root) ->
    Queue = queue:from_list([Root]),
    right_side_view(Queue, []).

right_side_view(Queue, Acc) ->
    case queue:is_empty(Queue) of
        true -> lists:reverse(Acc);
        false ->
            LevelSize = queue:len(Queue),
            LevelValues = get_level_values(Queue, LevelSize, []),
            NewQueue = queue:from_list(LevelValues),
            right_side_view(NewQueue, [lists:last(LevelValues) | Acc])
    end.

get_level_values(_Queue, 0, Acc) -> Acc;
get_level_values(Queue, N, Acc) ->
    {value, Node} = queue:out(Queue),
    {Left, Right} = node_children(Node),
    NewAcc = [Node | Acc],
    get_level_values(Queue, N - 1, NewAcc).

node_children(nil) -> {nil, nil};
node_children({Val, Left, Right}) -> {Left, Right}.