-module(longest_subarray).
-export([longest_subarray/2]).

longest_subarray(Nums, Limit) ->
    longest_subarray(Nums, Limit, 0, 0, 0, [], []).

longest_subarray([], _Limit, Start, End, MaxLen, _MinHeap, _MaxHeap) ->
    max(MaxLen, End - Start);
longest_subarray(Nums, Limit, Start, End, MaxLen, MinHeap, MaxHeap) ->
    [H|T] = Nums,
    {NewMinHeap, NewMaxHeap} = insert(H, MinHeap, MaxHeap),

    case abs(peek_max(NewMaxHeap) - peek_min(NewMinHeap)) =< Limit of
        true ->
            longest_subarray(T, Limit, Start, End + 1, max(MaxLen, End + 1 - Start), NewMinHeap, NewMaxHeap);
        false ->
            {NewStart, NewMinHeap2, NewMaxHeap2} = remove_start(T ++ [H], Limit, Start, End + 1, NewMinHeap, NewMaxHeap),
            longest_subarray(T ++ [H], Limit, NewStart, End + 1, MaxLen, NewMinHeap2, NewMaxHeap2)
    end.

insert(Num, MinHeap, MaxHeap) ->
    {insert_min(Num, MinHeap), insert_max(Num, MaxHeap)}.

insert_min(Num, MinHeap) ->
    heaps:insert(Num, MinHeap).

insert_max(Num, MaxHeap) ->
    heaps:insert(-Num, MaxHeap).

peek_min(MinHeap) ->
    case heaps:is_empty(MinHeap) of
        true ->
            -100001;
        false ->
            {value, Val} = heaps:get_max(MinHeap),
            Val
    end.

peek_max(MaxHeap) ->
    case heaps:is_empty(MaxHeap) of
        true ->
            100001;
        false ->
            {value, Val} = heaps:get_max(MaxHeap),
            -Val
    end.

remove_start(Nums, Limit, Start, End, MinHeap, MaxHeap) ->
    {_, NewMinHeap, NewMaxHeap} = remove_start_helper(Nums, Limit, Start, End, MinHeap, MaxHeap, Start),
    {Start + 1, NewMinHeap, NewMaxHeap}.

remove_start_helper(Nums, Limit, Start, End, MinHeap, MaxHeap, Current) ->
    [H|T] = Nums,
    Sliced = lists:sublist(Nums, Start + 1, End - Start),

    {NewMinHeap, NewMaxHeap} = remove(lists:nth(Start+1, Nums), MinHeap, MaxHeap),

    case abs(peek_max(NewMaxHeap) - peek_min(NewMinHeap)) =< Limit of
        true ->
            {true, NewMinHeap, NewMaxHeap};
        false ->
            {false, NewMinHeap, NewMaxHeap}
    end.

remove(Num, MinHeap, MaxHeap) ->
    {remove_min(Num, MinHeap), remove_max(Num, MaxHeap)}.

remove_min(Num, MinHeap) ->
    remove_element(Num, MinHeap).

remove_max(Num, MaxHeap) ->
    remove_element(-Num, MaxHeap).

remove_element(Element, Heap) ->
    remove_element_helper(Element, Heap, []).

remove_element_helper(Element, Heap, Acc) ->
    case heaps:is_empty(Heap) of
        true ->
            lists:foldl(fun(E, H) -> heaps:insert(E, H) end, heaps:new(), lists:reverse(Acc));
        false ->
            {value, Value} = heaps:get_max(Heap),
            NewHeap = heaps:delete_max(Heap),
            case Value =:= Element of
                true ->
                    lists:foldl(fun(E, H) -> heaps:insert(E, H) end, NewHeap, lists:reverse(Acc));
                false ->
                    remove_element_helper(Element, NewHeap, [Value | Acc])
            end
    end.