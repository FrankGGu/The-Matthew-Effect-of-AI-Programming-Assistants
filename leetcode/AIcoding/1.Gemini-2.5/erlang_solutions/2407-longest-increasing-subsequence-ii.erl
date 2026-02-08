-module(solution).
-export([longest_increasing_subsequence_ii/2]).

get_max(Node) ->
    if
        is_tuple(Node) -> element(1, Node);
        true -> Node
    end.

get_left(Node) ->
    if
        is_tuple(Node) -> element(2, Node);
        true -> 0
    end.

get_right(Node) ->
    if
        is_tuple(Node) -> element(3, Node);
        true -> 0
    end.

update(Tree, RangeLow, RangeHigh, TargetCoord, NewVal) ->
    if
        RangeLow == RangeHigh ->
            max(Tree, NewVal);
        true ->
            Mid = (RangeLow + RangeHigh) div 2,
            LeftChild = get_left(Tree),
            RightChild = get_right(Tree),

            NewLeftChild_val = 0,
            NewRightChild_val = 0,

            if
                TargetCoord <= Mid ->
                    NewLeftChild_val = update(LeftChild, RangeLow, Mid, TargetCoord, NewVal),
                    NewRightChild_val = RightChild;
                true ->
                    NewLeftChild_val = LeftChild,
                    NewRightChild_val = update(RightChild, Mid + 1, RangeHigh, TargetCoord, NewVal)
            end,

            NewMax = max(get_max(NewLeftChild_val), get_max(NewRightChild_val)),
            {NewMax, NewLeftChild_val, NewRightChild_val}
    end.

query(Tree, RangeLow, RangeHigh, QueryLow, QueryHigh) ->
    if
        RangeHigh < QueryLow; RangeLow > QueryHigh ->
            0;
        QueryLow <= RangeLow andalso RangeHigh <= QueryHigh ->
            get_max(Tree);
        true ->
            Mid = (RangeLow + RangeHigh) div 2,
            LeftMax = query(get_left(Tree), RangeLow, Mid, QueryLow, QueryHigh),
            RightMax = query(get_right(Tree), Mid + 1, RangeHigh, QueryLow, QueryHigh),
            max(LeftMax, RightMax)
    end.

longest_increasing_subsequence_ii(Nums, K) ->
    MaxCoord = 100000,
    InitialTree = 0,

    {_FinalTree, MaxLen} = lists:foldl(
        fun(Num, {CurrentTree, CurrentMaxLen}) ->
            LowerBound = max(1, Num - K),

            PrevMaxLen = query(CurrentTree, 1, MaxCoord, LowerBound, Num - 1),

            CurrentNumLen = PrevMaxLen + 1,

            NewTree = update(CurrentTree, 1, MaxCoord, Num, CurrentNumLen),

            NewMaxLen = max(CurrentMaxLen, CurrentNumLen),

            {NewTree, NewMaxLen}
        end,
        {InitialTree, 0},
        Nums
    ),
    MaxLen.