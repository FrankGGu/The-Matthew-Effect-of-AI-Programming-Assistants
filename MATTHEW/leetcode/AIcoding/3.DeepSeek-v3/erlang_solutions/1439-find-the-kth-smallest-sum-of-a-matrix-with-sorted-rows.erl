-spec kth_smallest(Matrix :: [[integer()]], K :: integer()) -> integer().
kth_smallest(Matrix, K) ->
    case Matrix of
        [] -> 0;
        _ ->
            Rows = length(Matrix),
            Cols = length(hd(Matrix)),
            Heap = gb_sets:new(),
            InitialSum = lists:sum([hd(Row) || Row <- Matrix]),
            InitialIndices = lists:duplicate(Rows, 1),
            Heap1 = gb_sets:add({InitialSum, InitialIndices}, Heap),
            Seen = sets:new(),
            Seen1 = sets:add_element(InitialIndices, Seen),
            kth_smallest(Matrix, K, Heap1, Seen1, Rows, Cols)
    end.

kth_smallest(_, 0, Heap, _, _, _) ->
    {Sum, _} = gb_sets:smallest(Heap),
    Sum;
kth_smallest(Matrix, K, Heap, Seen, Rows, Cols) ->
    {{Sum, Indices}, Heap1} = gb_sets:take_smallest(Heap),
    case K of
        1 -> Sum;
        _ ->
            NewHeap = lists:foldl(
                fun(I, Acc) ->
                    Row = lists:nth(I, Matrix),
                    CurrentIndex = lists:nth(I, Indices),
                    if
                        CurrentIndex < Cols ->
                            NewIndices = list_update(Indices, I, CurrentIndex + 1),
                            case sets:is_element(NewIndices, Seen) of
                                false ->
                                    NewSum = Sum - lists:nth(CurrentIndex, Row) + lists:nth(CurrentIndex + 1, Row),
                                    Seen2 = sets:add_element(NewIndices, Seen),
                                    gb_sets:add({NewSum, NewIndices}, Acc);
                                true ->
                                    Acc
                            end;
                        true ->
                            Acc
                    end
                end,
                Heap1,
                lists:seq(1, Rows)
            ),
            kth_smallest(Matrix, K - 1, NewHeap, Seen, Rows, Cols)
    end.

list_update(List, Index, Value) ->
    list_update(List, Index, Value, 1, []).

list_update([], _, _, _, Acc) ->
    lists:reverse(Acc);
list_update([H|T], Index, Value, Current, Acc) ->
    if
        Current =:= Index ->
            list_update(T, Index, Value, Current + 1, [Value|Acc]);
        true ->
            list_update(T, Index, Value, Current + 1, [H|Acc])
    end.