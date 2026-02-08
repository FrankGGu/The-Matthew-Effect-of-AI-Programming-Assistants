-module(solution).
-export([total_distinct_elements_sum_squares/1]).

-record(node, {sum_val = 0, sum_sq_val = 0, lazy_add = 0, left = nil, right = nil}).

total_distinct_elements_sum_squares(Nums) ->
    N = length(Nums),
    Mod = 1000000007,
    InitialTree = build_tree(0, N - 1),

    NumsArray = array:from_list(Nums),

    InitialState = #{tree => InitialTree, last_pos => #{}, total_sum => 0, n => N, mod => Mod, nums_array => NumsArray},

    lists:foldl(
        fun(J, Acc) ->
            Tree = maps:get(tree, Acc),
            LastPos = maps:get(last_pos, Acc),
            TotalSum = maps:get(total_sum, Acc),
            ModVal = maps:get(mod, Acc),
            NumsArr = maps:get(nums_array, Acc),

            Val = array:get(J, NumsArr),
            PrevIdx = maps:get(Val, LastPos, -1),

            NewTree1 = 
                if PrevIdx + 1 =< J ->
                    update_tree(Tree, 0, N - 1, PrevIdx + 1, J, 1, ModVal);
                true ->
                    Tree
                end,

            NewLastPos = maps:put(Val, J, LastPos),

            CurrentSumSq = query_tree(NewTree1, 0, N - 1, 0, J, ModVal),
            NewTotalSum = (TotalSum + CurrentSumSq) rem ModVal,

            Acc#{tree => NewTree1, last_pos => NewLastPos, total_sum => NewTotalSum}
        end,
        InitialState,
        lists:seq(0, N - 1)
    )#{total_sum}.

build_tree(L, R) ->
    if L == R ->
        #node{};
    true ->
        Mid = (L + R) div 2,
        LeftChild = build_tree(L, Mid),
        RightChild = build_tree(Mid + 1, R),
        #node{left = LeftChild, right = RightChild}
    end.

push_down(Node, CurrentL, CurrentR, Mod) ->
    Lazy = Node#node.lazy_add,
    if Lazy == 0 ->
        Node;
    true ->
        Mid = (CurrentL + CurrentR) div 2,
        LeftRangeSize = Mid - CurrentL + 1,
        RightRangeSize = CurrentR - (Mid + 1) + 1,

        NewLeft = update_child_with_lazy(Node#node.left, Lazy, LeftRangeSize, Mod),
        NewRight = update_child_with_lazy(Node#node.right, Lazy, RightRangeSize, Mod),
        Node#node{lazy_add = 0, left = NewLeft, right = NewRight}
    end.

update_child_with_lazy(ChildNode, Lazy, ChildRangeSize, Mod) ->
    NewSumSqVal = (ChildNode#node.sum_sq_val + mul(2, mul(Lazy, ChildNode#node.sum_val, Mod), Mod) + mul(mul(Lazy, Lazy, Mod), ChildRangeSize, Mod)) rem Mod,
    NewSumVal = (ChildNode#node.sum_val + mul(Lazy, ChildRangeSize, Mod)) rem Mod,
    NewLazyAdd = (ChildNode#node.lazy_add + Lazy) rem Mod,
    ChildNode#node{sum_val = NewSumVal, sum_sq_val = NewSumSqVal, lazy_add = NewLazyAdd}.

update_tree(Node, CurrentL, CurrentR, UpdateL, UpdateR, Value, Mod) ->
    if CurrentL > UpdateR orelse CurrentR < UpdateL ->
        Node;
    true when UpdateL =< CurrentL andalso CurrentR =< UpdateR ->
        RangeSize = CurrentR - CurrentL + 1,
        NewSumSqVal = (Node#node.sum_sq_val + mul(2, mul(Value, Node#node.sum_val, Mod), Mod) + mul(mul(Value, Value, Mod), RangeSize, Mod)) rem Mod,
        NewSumVal = (Node#node.sum_val + mul(Value, RangeSize, Mod)) rem Mod,
        NewLazyAdd = (Node#node.lazy_add + Value) rem Mod,
        Node#node{sum_val = NewSumVal, sum_sq_val = NewSumSqVal, lazy_add = NewLazyAdd};
    true ->
        PushedNode = push_down(Node, CurrentL, CurrentR, Mod),
        Mid = (CurrentL + CurrentR) div 2,

        NewLeft = update_tree(PushedNode#node.left, CurrentL, Mid, UpdateL, UpdateR, Value, Mod),
        NewRight = update_tree(PushedNode#node.right, Mid + 1, CurrentR, UpdateL, UpdateR, Value, Mod),

        NewSumVal = (NewLeft#node.sum_val + NewRight#node.sum_val) rem Mod,
        NewSumSqVal = (NewLeft#node.sum_sq_val + NewRight#node.sum_sq_val) rem Mod,

        PushedNode#node{sum_val = NewSumVal, sum_sq_val = NewSumSqVal, left = NewLeft, right = NewRight}
    end.

query_tree(Node, CurrentL, CurrentR, QueryL, QueryR, Mod) ->
    if CurrentL > QueryR orelse CurrentR < QueryL ->
        0;
    true when QueryL =< CurrentL andalso CurrentR =< QueryR ->
        Node#node.sum_sq_val;
    true ->
        PushedNode = push_down(Node, CurrentL, CurrentR, Mod),
        Mid = (CurrentL + CurrentR) div 2,

        LeftRes = query_tree(PushedNode#node.left, CurrentL, Mid, QueryL, QueryR, Mod),
        RightRes = query_tree(PushedNode#node.right, Mid + 1, CurrentR, QueryL, QueryR, Mod),

        (LeftRes + RightRes) rem Mod
    end.

mul(A, B, Mod) ->
    (A * B) rem Mod.