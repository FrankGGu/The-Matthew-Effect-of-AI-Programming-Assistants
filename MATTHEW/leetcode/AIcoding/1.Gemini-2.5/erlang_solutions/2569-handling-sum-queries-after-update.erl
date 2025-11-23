-module(solution).
-export([handle_query_after_update/3]).

-define(NUMS1_TABLE, nums1_table).

handle_query_after_update(Nums1List, Nums2List, Queries) ->
    N = length(Nums1List),
    Nums2GbArray = gb_array:from_list(Nums2List),

    ets:new(?NUMS1_TABLE, [set, public, named_table]),
    lists:foreach(fun({Idx, Val}) -> ets:insert(?NUMS1_TABLE, {Idx, Val}) end,
                  lists:zip(lists:seq(0, N - 1), Nums1List)),

    Tree = build(0, N - 1, Nums2GbArray),

    process_queries(Queries, Tree, Nums2GbArray, N, []).

process_queries([], _Tree, _Nums2GbArray, _N, Acc) ->
    lists:reverse(Acc);
process_queries([Query | Rest], Tree, Nums2GbArray, N, Acc) ->
    Type = hd(Query),
    case Type of
        1 ->
            [_Type, I, X] = Query,
            {_I, OldVal1} = hd(ets:lookup(?NUMS1_TABLE, I)),
            NewVal1 = OldVal1 + X,
            ets:insert(?NUMS1_TABLE, {I, NewVal1}),
            NewTree = update_point(0, N - 1, I, NewVal1, Nums2GbArray, Tree),
            process_queries(Rest, NewTree, Nums2GbArray, N, Acc);
        2 ->
            [_Type, I, J] = Query,
            NewTree = update_square(0, N - 1, I, J, Nums2GbArray, Tree),
            process_queries(Rest, NewTree, Nums2GbArray, N, Acc);
        3 ->
            [_Type, I, J] = Query,
            Sum = query_sum(0, N - 1, I, J, Tree),
            process_queries(Rest, Tree, Nums2GbArray, N, [Sum | Acc])
    end.

build(L, R, Nums2GbArray) ->
    if
        L == R ->
            {_L, Val1} = hd(ets:lookup(?NUMS1_TABLE, L)),
            Val2 = gb_array:get(L, Nums2GbArray),
            Sum = Val1 * Val2,
            AllZeroOne = (Val1 == 0 orelse Val1 == 1),
            {Sum, AllZeroOne};
        true ->
            Mid = (L + R) div 2,
            LeftChild = build(L, Mid, Nums2GbArray),
            RightChild = build(Mid + 1, R, Nums2GbArray),
            Sum = element(1, LeftChild) + element(1, RightChild),
            AllZeroOne = element(2, LeftChild) andalso element(2, RightChild),
            {Sum, AllZeroOne, LeftChild, RightChild}
    end.

update_point(L, R, TargetIdx, NewVal1, Nums2GbArray, CurrentNode) ->
    if
        L == R ->
            Val2 = gb_array:get(L, Nums2GbArray),
            NewSum = NewVal1 * Val2,
            NewAllZeroOne = (NewVal1 == 0 orelse NewVal1 == 1),
            {NewSum, NewAllZeroOne};
        true ->
            Mid = (L + R) div 2,
            {_Sum, _AllZeroOne, LeftChild, RightChild} = CurrentNode,
            NewLeftChild = LeftChild,
            NewRightChild = RightChild,
            if
                TargetIdx <= Mid ->
                    NewLeftChild = update_point(L, Mid, TargetIdx, NewVal1, Nums2GbArray, LeftChild);
                true ->
                    NewRightChild = update_point(Mid + 1, R, TargetIdx, NewVal1, Nums2GbArray, RightChild)
            end,
            NewSum = element(1, NewLeftChild) + element(1, NewRightChild),
            NewAllZeroOne = element(2, NewLeftChild) andalso element(2, NewRightChild),
            {NewSum, NewAllZeroOne, NewLeftChild, NewRightChild}
    end.

update_square(L, R, QueryL, QueryR, Nums2GbArray, CurrentNode) ->
    {_Sum, AllZeroOne, _LeftChild, _RightChild} = CurrentNode,
    if
        QueryR < L orelse QueryL > R ->
            CurrentNode;
        AllZeroOne ->
            CurrentNode;
        L == R ->
            {_L, Val1} = hd(ets:lookup(?NUMS1_TABLE, L)),
            NewVal1 = Val1 * Val1,
            ets:insert(?NUMS1_TABLE, {L, NewVal1}),

            Val2 = gb_array:get(L, Nums2GbArray),
            NewSum = NewVal1 * Val2,
            NewAllZeroOne = (NewVal1 == 0 orelse NewVal1 == 1),
            {NewSum, NewAllZeroOne};
        true ->
            Mid = (L + R) div 2,
            {_Sum, _AllZeroOne, LeftChild, RightChild} = CurrentNode,
            NewLeftChild = update_square(L, Mid, QueryL, QueryR, Nums2GbArray, LeftChild),
            NewRightChild = update_square(Mid + 1, R, QueryL, QueryR, Nums2GbArray, RightChild),
            NewSum = element(1, NewLeftChild) + element(1, NewRightChild),
            NewAllZeroOne = element(2, NewLeftChild) andalso element(2, NewRightChild),
            {NewSum, NewAllZeroOne, NewLeftChild, NewRightChild}
    end.

query_sum(L, R, QueryL, QueryR, CurrentNode) ->
    if
        QueryR < L orelse QueryL > R ->
            0;
        QueryL <= L andalso R <= QueryR ->
            element(1, CurrentNode);
        true ->
            Mid = (L + R) div 2,
            {_Sum, _AllZeroOne, LeftChild, RightChild} = CurrentNode,
            query_sum(L, Mid, QueryL, QueryR, LeftChild) +
            query_sum(Mid + 1, R, QueryL, QueryR, RightChild)
    end.