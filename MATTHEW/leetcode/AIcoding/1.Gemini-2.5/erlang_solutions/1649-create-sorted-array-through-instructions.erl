-module(solution).
-export([create_sorted_array/1]).

-define(MAX_COORD_VAL, 100000).
-define(BIT_SIZE, ?MAX_COORD_VAL + 1).

lowbit(X) -> X band (-X).

update(Tree, Idx, Val) ->
    update_iter(Tree, Idx, Val, ?BIT_SIZE).

update_iter(Tree, Idx, Val, MaxSize) when Idx < MaxSize ->
    CurrentVal = array:get(Idx, Tree),
    NewTree = array:set(Idx, CurrentVal + Val, Tree),
    NextIdx = Idx + lowbit(Idx),
    update_iter(NewTree, NextIdx, Val, MaxSize);
update_iter(Tree, _Idx, _Val, _MaxSize) ->
    Tree.

query(Tree, Idx) ->
    query_iter(Tree, Idx, 0).

query_iter(_Tree, Idx, Acc) when Idx =< 0 ->
    Acc;
query_iter(Tree, Idx, Acc) ->
    Val = array:get(Idx, Tree),
    query_iter(Tree, Idx - lowbit(Idx), Acc + Val).

create_sorted_array(Instructions) ->
    InitialTree = array:new(?BIT_SIZE, 0),
    process_instructions(Instructions, InitialTree, 0).

process_instructions([], _Tree, TotalCost) ->
    TotalCost;
process_instructions([H | T], Tree, CurrentTotalCost) ->
    CountLess = query(Tree, H - 1),
    CountEqual = query(Tree, H) - CountLess,
    TotalElementsSoFar = query(Tree, ?MAX_COORD_VAL),
    CountGreater = TotalElementsSoFar - CountLess - CountEqual,
    Cost = min(CountLess, CountGreater),
    NewTree = update(Tree, H, 1),
    process_instructions(T, NewTree, CurrentTotalCost + Cost).