-module(solution).
-export([solve/1]).

-record(node, {
    y_low_idx,
    y_high_idx,
    sum = 0,
    max_val = 0,
    lazy_add = 0,
    left = nil,
    right = nil
}).

solve(Rectangles) ->
    YCoords = lists:sort(lists:uniq(lists:flatten([ [Y1, Y2] || [_, Y1, _, Y2, _] <- Rectangles ]))),

    if 
        length(YCoords) < 2 -> 0;
        true ->
            YMap = create_y_map(YCoords, 0, #{}),

            Events = lists:sort(
                lists:flatten([
                    [{X1, 1, maps:get(Y1, YMap), maps:get(Y2, YMap), Value},
                     {X2, -1, maps:get(Y1, YMap), maps:get(Y2, YMap), Value}]
                    || [X1, Y1, X2, Y2, Value] <- Rectangles
                ])
            ),

            MaxIntervalIdx = length(YCoords) - 2,
            InitialTree = build_segment_tree(0, MaxIntervalIdx),

            sweep(Events, InitialTree, 0)
    end.

create_y_map([], _, Acc) -> Acc;
create_y_map([Y | Rest], Idx, Acc) ->
    create_y_map(Rest, Idx + 1, maps:put(Y, Idx, Acc)).

build_segment_tree(YLowIdx, YHighIdx) when YLowIdx > YHighIdx -> nil;
build_segment_tree(YLowIdx, YHighIdx) ->
    Node = #node{y_low_idx = YLowIdx, y_high_idx = YHighIdx},
    if
        YLowIdx == YHighIdx -> Node;
        true ->
            MidIdx = YLowIdx + (YHighIdx - YLowIdx) div 2,
            Node#node{
                left = build_segment_tree(YLowIdx, MidIdx),
                right = build_segment_tree(MidIdx + 1, YHighIdx)
            }
    end.

update_segment_tree(Tree, QueryYLowIdx, QueryYHighIdx, Value) ->
    update_segment_tree_recursive(Tree, QueryYLowIdx, QueryYHighIdx, Value).

update_segment_tree_recursive(nil, _, _, _) -> nil;
update_segment_tree_recursive(Tree, QueryYLowIdx, QueryYHighIdx, Value) ->
    if
        Tree#node.y_high_idx < QueryYLowIdx; Tree#node.y_low_idx > QueryYHighIdx ->
            Tree;
        true ->
            NewTree = push_down_lazy(Tree),
            if
                QueryYLowIdx =< NewTree#node.y_low_idx andalso NewTree#node.y_high_idx =< QueryYHighIdx ->
                    NewTree#node{
                        sum = NewTree#node.sum + Value,
                        max_val = NewTree#node.max_val + Value,
                        lazy_add = NewTree#node.lazy_add + Value
                    };
                true ->
                    LeftChild = update_segment_tree_recursive(NewTree#node.left, QueryYLowIdx, QueryYHighIdx, Value),
                    RightChild = update_segment_tree_recursive(NewTree#node.right, QueryYLowIdx, QueryYHighIdx, Value),
                    NewTree#node{
                        left = LeftChild,
                        right = RightChild,
                        sum = get_sum(LeftChild) + get_sum(RightChild),
                        max_val = max(get_max(LeftChild), get_max(RightChild))
                    }
            end
    end.

push_down_lazy(Node) when Node#node.lazy_add == 0 -> Node;
push_down_lazy(Node) ->
    LazyVal = Node#node.lazy_add,
    LeftChild = Node#node.left,
    RightChild = Node#node.right,
    NewLeft = if
        LeftChild == nil -> nil;
        true -> LeftChild#node{
            sum = LeftChild#node.sum + LazyVal,
            max_val = LeftChild#node.max_val + LazyVal,
            lazy_add = LeftChild#node.lazy_add + LazyVal
        }
    end,
    NewRight = if
        RightChild == nil -> nil;
        true -> RightChild#node{
            sum = RightChild#node.sum + LazyVal,
            max_val = RightChild#node.max_val + LazyVal,
            lazy_add = RightChild#node.lazy_add + LazyVal
        }
    end,
    Node#node{left = NewLeft, right = NewRight, lazy_add = 0}.

get_sum(nil) -> 0;
get_sum(Node) -> Node#node.sum.

get_max(nil) -> 0;
get_max(Node) -> Node#node.max_val.

sweep([], _, MaxBlessing) -> MaxBlessing;
sweep([{_X, Type, YLowIdx, YHighIdx, Value} | Rest], CurrentTree, MaxBlessing) ->
    UpdatedTree = update_segment_tree(CurrentTree, YLowIdx, YHighIdx - 1, Type * Value),
    CurrentMaxBlessing = get_max(UpdatedTree),
    NewMaxBlessing = max(MaxBlessing, CurrentMaxBlessing),
    sweep(Rest, UpdatedTree, NewMaxBlessing).