-module(solution).
-export([closestNodes/2]).

-record('TreeNode', {val, left, right}).

closestNodes(Root, Queries) ->
    SortedVals = inorder_efficient(Root, []),
    Array = array:from_list(SortedVals),
    MaxIdx = array:size(Array) - 1,
    lists:map(fun(Query) ->
                  MinVal = find_floor(Array, Query, 0, MaxIdx, -1),
                  MaxVal = find_ceil(Array, Query, 0, MaxIdx, -1),
                  [MinVal, MaxVal]
              end, Queries).

inorder_efficient(nil, Acc) -> Acc;
inorder_efficient(#'TreeNode'{val = Val, left = Left, right = Right}, Acc) ->
    inorder_efficient(Left, [Val | inorder_efficient(Right, Acc)]).

find_floor(Array, Target, Low, High, CurrentFloor) ->
    if Low > High -> CurrentFloor;
       true ->
            Mid = Low + (High - Low) div 2,
            Val = array:get(Mid, Array),
            if Val == Target -> Val;
               Val < Target -> find_floor(Array, Target, Mid + 1, High, Val);
               Val > Target -> find_floor(Array, Target, Low, Mid - 1, CurrentFloor)
            end
    end.

find_ceil(Array, Target, Low, High, CurrentCeil) ->
    if Low > High -> CurrentCeil;
       true ->
            Mid = Low + (High - Low) div 2,
            Val = array:get(Mid, Array),
            if Val == Target -> Val;
               Val < Target -> find_ceil(Array, Target, Mid + 1, High, CurrentCeil);
               Val > Target -> find_ceil(Array, Target, Low, Mid - 1, Val)
            end
    end.