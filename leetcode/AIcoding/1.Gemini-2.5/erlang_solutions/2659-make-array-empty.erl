-module(solution).
-export([makeArrayEmpty/2]).

bit_new(Size) ->
    array:new({1, Size}, 0).

bit_update(Bit, Idx, Val) when Idx > 0 ->
    Size = array:size(Bit),
    bit_update_loop(Bit, Idx, Val, Size).

bit_update_loop(Bit, Idx, Val, Size) when Idx =< Size ->
    CurrentVal = array:get(Idx, Bit),
    NewBit = array:set(Idx, CurrentVal + Val, Bit),
    bit_update_loop(NewBit, Idx + (Idx band -Idx), Val, Size);
bit_update_loop(Bit, _, _, _) ->
    Bit.

bit_query(Bit, Idx) when Idx > 0 ->
    bit_query_loop(Bit, Idx, 0).

bit_query_loop(Bit, Idx, Sum) when Idx > 0 ->
    CurrentVal = array:get(Idx, Bit),
    bit_query_loop(Bit, Idx - (Idx band -Idx), Sum + CurrentVal);
bit_query_loop(_, _, Sum) ->
    Sum.

makeArrayEmpty(Nums, Cost) ->
    N = length(Nums),
    Items = make_items(Nums, Cost, 0, []),
    SortedItems = lists:sort(fun({V1, Idx1, _}, {V2, Idx2, _}) ->
                                 if V1 < V2 -> true;
                                    V1 > V2 -> false;
                                    true -> Idx1 > Idx2 % For same values, sort by decreasing original index
                                 end
                             end, Items),

    BIT = bit_new(N),
    calculate_total_cost(SortedItems, BIT, N, 0).

make_items([], [], _, Acc) -> lists:reverse(Acc);
make_items([Num|RestNums], [C|RestCost], Idx, Acc) ->
    make_items(RestNums, RestCost, Idx + 1, [{Num, Idx, C}|Acc]).

calculate_total_cost([], _, _, TotalCost) -> TotalCost;
calculate_total_cost([{_Value, OriginalIndex, ItemCost}|RestItems], BIT, N, CurrentTotalCost) ->
    %% K_val is the number of elements to the right of OriginalIndex that have been removed.
    %% This is calculated as (total removed elements) - (removed elements up to OriginalIndex).
    K_val = bit_query(BIT, N) - bit_query(BIT, OriginalIndex + 1),
    NewTotalCost = CurrentTotalCost + (ItemCost * K_val),
    %% Mark the current element as removed in the BIT.
    NewBIT = bit_update(BIT, OriginalIndex + 1, 1),
    calculate_total_cost(RestItems, NewBIT, N, NewTotalCost).