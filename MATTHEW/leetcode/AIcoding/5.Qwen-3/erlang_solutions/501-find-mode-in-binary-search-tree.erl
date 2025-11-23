-module(find_mode_in_binary_search_tree).
-export([findMode/1]).

findMode(Null) when Null =:= null -> [];
findMode(Root) ->
    {_, ModeList} = traverse(Root, #{}),
    ModeList.

traverse(null, Acc) -> {Acc, []};
traverse(#bst{val = Val, left = Left, right = Right}, Acc) ->
    Count = maps:get(Val, Acc, 0) + 1,
    NewAcc = maps:put(Val, Count, Acc),
    {LeftAcc, _} = traverse(Left, NewAcc),
    {RightAcc, _} = traverse(Right, LeftAcc),
    {RightAcc, []}.

-record(bst, {val, left, right}).