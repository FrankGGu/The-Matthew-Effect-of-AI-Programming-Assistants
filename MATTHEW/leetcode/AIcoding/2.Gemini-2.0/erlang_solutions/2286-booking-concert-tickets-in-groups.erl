-module(booking_concert_tickets).
-export([make_booking_manager/2, scatter_seats/2, gather_seats/3]).

make_booking_manager(N, M) ->
    {array:new({1, N}, {0, M}), min_heap:new()}.

scatter_seats({Array, Heap}, K) ->
    case min_heap:is_empty(Heap) of
        true ->
            case array:get(1, Array) of
                {_, M} when M >= K ->
                    NewArray = array:set(1, M - K, Array),
                    {true, {NewArray, Heap}};
                _ ->
                    {false, {Array, Heap}}
            end;
        false ->
            {Row, Remaining} = min_heap:extract_min(Heap),
            case Remaining >= K of
                true ->
                    NewRemaining = Remaining - K,
                    NewArray = array:set(Row, NewRemaining, Array),
                    NewHeap = case NewRemaining of
                                  0 -> Heap;
                                  _ -> min_heap:insert(Row, NewRemaining, Heap)
                              end,
                    {true, {NewArray, NewHeap}};
                false ->
                    case array:get(Row + 1, Array) of
                        {_, M} when M >= K ->
                            NewArray = array:set(Row + 1, M - K, Array),
                            NewHeap = min_heap:insert(Row, Remaining, Heap),
                            {true, {NewArray, NewHeap}};
                        _ ->
                            NewHeap = min_heap:insert(Row, Remaining, Heap),
                            {false, {Array, NewHeap}}
                    end
            end
    end.

gather_seats({Array, Heap}, K, MaxRow) ->
    gather_seats({Array, Heap}, K, MaxRow, 1, []).

gather_seats({Array, Heap}, 0, _, _, Acc) ->
    {Acc, {Array, Heap}};
gather_seats({Array, Heap}, K, MaxRow, Row, Acc) when Row > MaxRow ->
    {[], {Array, Heap}};
gather_seats({Array, Heap}, K, MaxRow, Row, Acc) ->
    {Remaining, Max} = array:get(Row, Array),
    case Max >= K of
        true ->
            NewArray = array:set(Row, Max - K, Array),
            NewHeap = case Max - K of
                          0 -> Heap;
                          _ -> min_heap:insert(Row, Max - K, Heap)
                      end,
            {[Row | Acc], {NewArray, NewHeap}};
        false ->
            case Max > 0 of
                true ->
                    NewArray = array:set(Row, 0, Array),
                    NewHeap = Heap,
                    gather_seats({NewArray, NewHeap}, K - Max, MaxRow, Row + 1, [Row | Acc]);
                false ->
                    gather_seats({Array, Heap}, K, MaxRow, Row + 1, Acc)
            end
    end.