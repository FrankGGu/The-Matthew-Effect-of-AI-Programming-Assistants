-module(solution).
-export([count_pairs/2]).

-record(bit, {size, tree}).

bit_new(Size) ->
    #bit{size = Size, tree = array:new([{size, Size + 1}, {fixed, true}, {default, 0}])}.

bit_update(#bit{size = Size, tree = Tree} = Bit, Idx0, Delta) ->
    Idx = Idx0 + 1, %% Convert to 1-based
    bit_update_loop(Idx, Size, Delta, Tree, Bit).

bit_update_loop(Idx, Size, Delta, Tree, Bit) when Idx =< Size ->
    NewTree = array:set(Idx, array:get(Idx, Tree) + Delta, Tree),
    bit_update_loop(Idx + (Idx band -Idx), Size, Delta, NewTree, Bit);
bit_update_loop(_, _, _, Tree, Bit) ->
    Bit#bit{tree = Tree}.

bit_query_prefix(#bit{tree = Tree}, Idx0) ->
    Idx = Idx0 + 1, %% Convert to 1-based
    bit_query_prefix_loop(Idx, Tree, 0).

bit_query_prefix_loop(Idx, Tree, Sum) when Idx > 0 ->
    NewSum = Sum + array:get(Idx, Tree),
    bit_query_prefix_loop(Idx - (Idx band -Idx), Tree, NewSum);
bit_query_prefix_loop(_, _, Sum) ->
    Sum.

bit_query_range(Bit, LowIdx0, HighIdx0) ->
    bit_query_prefix(Bit, HighIdx0) - bit_query_prefix(Bit, LowIdx0 - 1).

compress_coords(Values) ->
    SortedUnique = lists:sort(lists:usort(Values)),
    Map = maps:from_list(lists:zip(SortedUnique, lists:seq(0, length(SortedUnique) - 1))),
    {Map, SortedUnique}.

get_compressed_idx(Map, Value) ->
    maps:get(Value, Map).

binary_search_lower_bound(List, Value) ->
    binary_search_lower_bound(List, Value, 0, length(List) - 1).

binary_search_lower_bound(List, Value, Low, High) when Low > High ->
    Low;
binary_search_lower_bound(List, Value, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = lists:nth(Mid + 1, List), %% lists:nth is 1-based
    if
        Element < Value ->
            binary_search_lower_bound(List, Value, Mid + 1, High);
        true ->
            binary_search_lower_bound(List, Value, Low, Mid - 1)
    end.

binary_search_upper_bound(List, Value) ->
    binary_search_upper_bound(List, Value, 0, length(List) - 1).

binary_search_upper_bound(List, Value, Low, High) when Low > High ->
    Low;
binary_search_upper_bound(List, Value, Low, High) ->
    Mid = Low + (High - Low) div 2,
    Element = lists:nth(Mid + 1, List),
    if
        Element =< Value ->
            binary_search_upper_bound(List, Value, Mid + 1, High);
        true ->
            binary_search_upper_bound(List, Value, Low, Mid - 1)
    end.

get_range_compressed_indices(SortedUnique, LowVal, HighVal) ->
    LowIdx = binary_search_lower_bound(SortedUnique, LowVal),
    HighIdx = binary_search_upper_bound(SortedUnique, HighVal) - 1,
    {LowIdx, HighIdx}.

-define(EVENT_REMOVE, 0).
-define(EVENT_ADD, 1).
-define(EVENT_QUERY, 2).

event_compare({U1, Type1, _}, {U2, Type2, _}) ->
    if
        U1 < U2 -> true;
        U1 > U2 -> false;
        true -> Type1 < Type2
    end.

count_pairs(Points, K) ->
    CountRectK = count_rect_pairs(Points, K),
    CountRectKMinus1 = if K > 0 -> count_rect_pairs(Points, K - 1); true -> 0 end,
    CountRectK - CountRectKMinus1.

count_rect_pairs(Points, D) ->
    TransformedPoints = [{X + Y, X - Y} || {X, Y} <- Points],

    V_coords = [V || {_, V} <- TransformedPoints],
    {V_map, SortedUniqueV} = compress_coords(V_coords),
    V_size = length(SortedUniqueV),

    Events = lists:flatmap(fun({U, V}) ->
                                   V_idx = get_compressed_idx(V_map, V),
                                   V_low = V - D,
                                   V_high = V + D,
                                   [{U - D, ?EVENT_ADD, V_idx},
                                    {U, ?EVENT_QUERY, V_idx, V_low, V_high},
                                    {U + D + 1, ?EVENT_REMOVE, V_idx}]
                           end, TransformedPoints),

    SortedEvents = lists:sort(fun event_compare/2, Events),

    TotalCount = process_events(SortedEvents, bit_new(V_size), SortedUniqueV, 0),

    TotalCount div 2. %% Each pair (P_i, P_j) is counted twice.

process_events([], _Bit, _SortedUniqueV, Acc) ->
    Acc;
process_events([{_U_event, ?EVENT_ADD, V_idx} | Rest], Bit, SortedUniqueV, Acc) ->
    NewBit = bit_update(Bit, V_idx, 1),
    process_events(Rest, NewBit, SortedUniqueV, Acc);
process_events([{_U_event, ?EVENT_REMOVE, V_idx} | Rest], Bit, SortedUniqueV, Acc) ->
    NewBit = bit_update(Bit, V_idx, -1),
    process_events(Rest, NewBit, SortedUniqueV, Acc);
process_events([{_U_event, ?EVENT_QUERY, _V_idx_i, V_low, V_high} | Rest], Bit, SortedUniqueV, Acc) ->
    {V_low_idx, V_high_idx} = get_range_compressed_indices(SortedUniqueV, V_low, V_high),

    Count = if V_low_idx =< V_high_idx ->
                bit_query_range(Bit, V_low_idx, V_high_idx);
            true ->
                0
            end,

    %% Subtract 1 for the point itself, as it's included in the BIT and query result.
    %% This ensures we only count distinct pairs (P_j, P_i) where P_j != P_i.
    NewAcc = Acc + (Count - 1),
    process_events(Rest, Bit, SortedUniqueV, NewAcc).