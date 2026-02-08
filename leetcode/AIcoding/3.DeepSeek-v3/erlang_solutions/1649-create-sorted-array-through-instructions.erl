-module(solution).
-export([create_sorted_array/1]).

create_sorted_array(Instructions) ->
    Tree = nil,
    {Cost, _} = lists:foldl(fun(X, {Acc, T}) ->
        Less = count_less(T, X),
        Greater = count_greater(T, X),
        NewCost = (Acc + min(Less, Greater)) rem 1000000007,
        {NewCost, insert(T, X)}
    end, {0, Tree}, Instructions),
    Cost.

count_less(nil, _) -> 0;
count_less({Value, Left, Right, Size}, X) ->
    if
        X > Value ->
            node_size(Left) + 1 + count_less(Right, X);
        true ->
            count_less(Left, X)
    end.

count_greater(nil, _) -> 0;
count_greater({Value, Left, Right, Size}, X) ->
    if
        X < Value ->
            node_size(Right) + 1 + count_greater(Left, X);
        true ->
            count_greater(Right, X)
    end.

insert(nil, X) -> {X, nil, nil, 1};
insert({Value, Left, Right, Size}, X) ->
    if
        X < Value ->
            NewLeft = insert(Left, X),
            {Value, NewLeft, Right, node_size(NewLeft) + node_size(Right) + 1};
        true ->
            NewRight = insert(Right, X),
            {Value, Left, NewRight, node_size(Left) + node_size(NewRight) + 1}
    end.

node_size(nil) -> 0;
node_size({_, _, _, Size}) -> Size.