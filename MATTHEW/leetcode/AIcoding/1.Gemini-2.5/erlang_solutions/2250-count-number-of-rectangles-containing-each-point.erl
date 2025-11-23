-module(solution).
-export([countRectangles/2]).

bit_new(MaxHeight) ->
    array:new(MaxHeight + 1, {default, 0}).

bit_update(BitArray, Idx, Val) ->
    MaxIdx = array:size(BitArray) - 1,
    bit_update_loop(BitArray, Idx, Val, MaxIdx).

bit_update_loop(BitArray, CurrentIdx, Val, MaxIdx) when CurrentIdx =< MaxIdx ->
    OldVal = array:get(CurrentIdx, BitArray),
    UpdatedBitArray = array:set(CurrentIdx, OldVal + Val, BitArray),
    bit_update_loop(UpdatedBitArray, CurrentIdx + (CurrentIdx band -CurrentIdx), Val, MaxIdx);
bit_update_loop(BitArray, _CurrentIdx, _Val, _MaxIdx) ->
    BitArray.

bit_query(BitArray, Idx) ->
    bit_query_loop(BitArray, Idx, 0).

bit_query_loop(_BitArray, CurrentIdx, Sum) when CurrentIdx > 0 ->
    Val = array:get(CurrentIdx, _BitArray),
    bit_query_loop(_BitArray, CurrentIdx - (CurrentIdx band -CurrentIdx), Sum + Val);
bit_query_loop(_BitArray, _CurrentIdx, Sum) ->
    Sum.

bit_query_suffix_sum(BitArray, Py, MaxHeight) ->
    TotalSum = bit_query(BitArray, MaxHeight),
    SumBeforePy = bit_query(BitArray, Py - 1),
    TotalSum - SumBeforePy.

countRectangles(Rectangles, Points) ->
    MaxHeight = 100,
    NumPoints = length(Points),

    RectangleEvents = lists:map(fun([L, H]) -> {{L, 0}, H} end, Rectangles),
    PointEvents = lists:map(fun({Idx, [Px, Py]}) -> {{Px, 1}, Py, Idx} end, lists:zip(lists:seq(0, NumPoints - 1), Points)),

    AllEvents = RectangleEvents ++ PointEvents,

    SortedEvents = lists:sort(fun({{X1, Type1}, _}, {{X2, Type2}, _}) ->
                                      if X1 =/= X2 -> X1 > X2;
                                         true -> Type1 < Type2
                                      end
                              end, AllEvents),

    ResultsArray = array:new(NumPoints, {default, 0}),

    Bit = bit_new(MaxHeight),

    process_events(SortedEvents, Bit, ResultsArray, MaxHeight).

process_events([], _Bit, ResultsArray, _MaxHeight) ->
    array:to_list(ResultsArray);
process_events([{{L, 0}, H} | Rest], Bit, ResultsArray, MaxHeight) ->
    NewBit = bit_update(Bit, H, 1),
    process_events(Rest, NewBit, ResultsArray, MaxHeight);
process_events([{{Px, 1}, Py, OriginalIdx} | Rest], Bit, ResultsArray, MaxHeight) ->
    Count = bit_query_suffix_sum(Bit, Py, MaxHeight),
    NewResultsArray = array:set(OriginalIdx, Count, ResultsArray),
    process_events(Rest, Bit, NewResultsArray, MaxHeight).