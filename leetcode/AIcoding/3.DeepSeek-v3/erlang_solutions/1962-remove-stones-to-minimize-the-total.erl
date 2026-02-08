-module(solution).
-export([min_stone_sum/2]).

min_stone_sum(Piles, K) ->
    MaxHeap = lists:foldl(fun(X, Acc) -> 
                            heap:insert(-X, Acc) 
                          end, heap:new(), Piles),
    {Sum, _} = lists:foldl(fun(_, {CurrentSum, Heap}) ->
                            case heap:is_empty(Heap) of
                                true -> {CurrentSum, Heap};
                                false ->
                                    {Max, NewHeap} = heap:extract(Heap),
                                    Stone = -Max,
                                    Removed = Stone div 2,
                                    NewStone = Stone - Removed,
                                    NewSum = CurrentSum - Removed,
                                    UpdatedHeap = heap:insert(-NewStone, NewHeap),
                                    {NewSum, UpdatedHeap}
                            end
                          end, {lists:sum(Piles), MaxHeap}, lists:seq(1, K)),
    Sum.