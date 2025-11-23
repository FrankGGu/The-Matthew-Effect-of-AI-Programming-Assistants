-module(num_array).
-export([new/1, update/3, sum_range/3]).

new(Nums) ->
    {ok, {tree, build_tree(Nums, 1, length(Nums))}}.

build_tree([], _Start, _End) ->
    nil;
build_tree(Nums, Start, End) ->
    if
        Start == End ->
            {leaf, Start, End, lists:nth(Start, Nums)};
        true ->
            Mid = (Start + End) div 2,
            Left = build_tree(Nums, Start, Mid),
            Right = build_tree(Nums, Mid + 1, End),
            Sum = get_sum(Left) + get_sum(Right),
            {node, Start, End, Sum, Left, Right}
    end.

update({ok, {tree, Tree}}, Index, Val) ->
    {ok, {tree, update_tree(Tree, Index, Val)}}.

update_tree({leaf, Start, End, _}, Index, Val) ->
    if
        Start == Index and End == Index ->
            {leaf, Start, End, Val};
        true ->
            {leaf, Start, End, Val}
    end;
update_tree({node, Start, End, _, Left, Right}, Index, Val) ->
    Mid = (Start + End) div 2,
    if
        Index >= Start and Index <= Mid ->
            NewLeft = update_tree(Left, Index, Val),
            NewSum = get_sum(NewLeft) + get_sum(Right),
            {node, Start, End, NewSum, NewLeft, Right};
        true ->
            NewRight = update_tree(Right, Index, Val),
            NewSum = get_sum(Left) + get_sum(NewRight),
            {node, Start, End, NewSum, Left, NewRight}
    end;
update_tree(nil, _, _) ->
    nil.

sum_range({ok, {tree, Tree}}, Left, Right) ->
    sum_range_tree(Tree, Left, Right).

sum_range_tree({leaf, Start, End, Val}, Left, Right) ->
    if
        Start >= Left and End <= Right ->
            Val;
        true ->
            Val
    end;
sum_range_tree({node, Start, End, _, LeftChild, RightChild}, Left, Right) ->
    if
        Left > End or Right < Start ->
            0;
        true ->
            Mid = (Start + End) div 2,
            LeftSum = sum_range_tree(LeftChild, Left, min(Right, Mid)),
            RightSum = sum_range_tree(RightChild, max(Left, Mid + 1), Right),
            LeftSum + RightSum
    end;
sum_range_tree(nil, _, _) ->
    0.

get_sum({leaf, _, _, Sum}) ->
    Sum;
get_sum({node, _, _, Sum, _, _}) ->
    Sum;
get_sum(nil) ->
    0.

min(A, B) ->
    if A < B -> A; true -> B end.

max(A, B) ->
    if A > B -> A; true -> B end.