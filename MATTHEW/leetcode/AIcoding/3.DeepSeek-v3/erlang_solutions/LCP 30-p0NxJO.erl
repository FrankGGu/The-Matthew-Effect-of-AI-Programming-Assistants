-module(solution).
-export([magic_tower/1]).

magic_tower(Nums) ->
    magic_tower(Nums, 0, 0, []).

magic_tower([], Sum, Negs, Heap) when Sum >= 0 -> length(Negs);
magic_tower([], _Sum, _Negs, _Heap) -> -1;
magic_tower([Num | Rest], Sum, Negs, Heap) ->
    NewSum = Sum + Num,
    if
        Num < 0 ->
            NewHeap = insert(Heap, Num),
            if
                NewSum < 0 ->
                    {Min, NewHeap1} = extract_min(NewHeap),
                    NewSum1 = NewSum - Min,
                    magic_tower(Rest, NewSum1, [Min | Negs], NewHeap1);
                true ->
                    magic_tower(Rest, NewSum, Negs, NewHeap)
            end;
        true ->
            magic_tower(Rest, NewSum, Negs, Heap)
    end.

insert([], Num) -> [Num];
insert([H | T], Num) when Num < H -> [Num, H | T];
insert([H | T], Num) -> [H | insert(T, Num)].

extract_min([Min | Rest]) -> {Min, Rest}.