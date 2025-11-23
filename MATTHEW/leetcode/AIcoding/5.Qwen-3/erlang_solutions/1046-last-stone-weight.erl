-module(last_stone_weight).
-export([last_stone_weight/1]).

last_stone_weight(Stones) ->
    Heap = lists:reverse(Stones),
    last_stone_weight(Heap).

last_stone_weight([]) ->
    0;
last_stone_weight([X]) ->
    X;
last_stone_weight(Heap) ->
    {A, B, NewHeap} = extract_max_two(Heap),
    if
        A == B ->
            last_stone_weight(NewHeap);
        true ->
            NewStone = A - B,
            last_stone_weight([NewStone | NewHeap])
    end.

extract_max_two([A, B | Rest]) ->
    {A, B, Rest};
extract_max_two([A | Rest]) ->
    {A, 0, Rest}.