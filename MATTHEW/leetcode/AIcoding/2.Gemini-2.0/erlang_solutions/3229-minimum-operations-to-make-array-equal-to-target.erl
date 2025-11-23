-module(minimum_operations).
-export([minOperations/2]).

minOperations(Nums, Target) ->
    minOperations_helper(Nums, Target, 0).

minOperations_helper([], Target, Count) ->
    if Target == 0 then
        Count
    else
        -1
    end;
minOperations_helper(Nums, Target, Count) ->
    Sum = lists:sum(Nums),
    if Sum < Target then
        -1
    else
        {NewNums, NewCount} = split_nums(Nums, Count),
        minOperations_helper(NewNums, Target, NewCount)
    end.

split_nums(Nums, Count) ->
    Sum = lists:sum(Nums),
    MaxVal = lists:max(Nums),
    if Sum =:= MaxVal then
        split_single(Nums, Count)
    else

        MaxIndex = lists:keyfind(MaxVal, 1, lists:zip(lists:seq(1, length(Nums)), Nums)),

        {NewNums, NewCount} = split_index(Nums, element(1, MaxIndex), Count),
        {NewNums, NewCount}
    end.

split_single([Val], Count) ->
    {[Val div 2, Val div 2], Count + 1};
split_single(Nums, Count) ->
    MaxVal = lists:max(Nums),
    MaxIndex = lists:keyfind(MaxVal, 1, lists:zip(lists:seq(1, length(Nums)), Nums)),
    split_index(Nums, element(1, MaxIndex), Count).

split_index(Nums, Index, Count) ->
    Val = lists:nth(Index, Nums),
    NewVal = Val div 2,
    NewNums = lists:map(fun(X) -> X end, Nums),
    NewNums1 = lists:nthtail(Index, NewNums),
    NewNums2 = lists:droplast(length(NewNums) - Index + 1, NewNums),

    NewNums1_1 = [NewVal | lists:nthtail(1, NewNums1)],

    NewNums_final = NewNums2 ++ NewNums1_1 ++ [NewVal] ,

    {NewNums_final, Count + 1}.