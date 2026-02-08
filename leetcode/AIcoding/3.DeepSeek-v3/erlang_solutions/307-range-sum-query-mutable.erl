-module(num_array).

-export([init/1, update/3, sum_range/3]).

init(Nums) ->
    Size = length(Nums),
    Tree = build_segment_tree(Nums, 0, Size - 1),
    {Tree, Size}.

update({Tree, Size}, Index, Val) ->
    update_segment_tree(Tree, 0, Size - 1, Index, Val),
    {Tree, Size}.

sum_range({Tree, Size}, Left, Right) ->
    query_segment_tree(Tree, 0, Size - 1, Left, Right).

build_segment_tree(Nums, Start, End) ->
    case Start of
        End ->
            #{
                start => Start,
                'end' => End,
                sum => lists:nth(Start + 1, Nums)
            };
        _ ->
            Mid = (Start + End) div 2,
            Left = build_segment_tree(Nums, Start, Mid),
            Right = build_segment_tree(Nums, Mid + 1, End),
            #{
                start => Start,
                'end' => End,
                sum => maps:get(sum, Left) + maps:get(sum, Right),
                left => Left,
                right => Right
            }
    end.

update_segment_tree(Node, Start, End, Index, Val) ->
    CurrentStart = maps:get(start, Node),
    CurrentEnd = maps:get('end', Node),
    case CurrentStart =:= CurrentEnd of
        true ->
            Node#{sum := Val};
        false ->
            Left = maps:get(left, Node),
            Right = maps:get(right, Node),
            Mid = (CurrentStart + CurrentEnd) div 2,
            if
                Index =< Mid ->
                    NewLeft = update_segment_tree(Left, Start, End, Index, Val),
                    Sum = maps:get(sum, NewLeft) + maps:get(sum, Right),
                    Node#{left := NewLeft, sum := Sum};
                true ->
                    NewRight = update_segment_tree(Right, Start, End, Index, Val),
                    Sum = maps:get(sum, Left) + maps:get(sum, NewRight),
                    Node#{right := NewRight, sum := Sum}
            end
    end.

query_segment_tree(Node, Start, End, Left, Right) ->
    CurrentStart = maps:get(start, Node),
    CurrentEnd = maps:get('end', Node),
    if
        Left =< CurrentStart andalso Right >= CurrentEnd ->
            maps:get(sum, Node);
        CurrentEnd < Left orelse CurrentStart > Right ->
            0;
        true ->
            LeftSum = query_segment_tree(maps:get(left, Node), Start, End, Left, Right),
            RightSum = query_segment_tree(maps:get(right, Node), Start, End, Left, Right),
            LeftSum + RightSum
    end.