-module(solution).
-export([remove_stones/2]).

remove_stones(Piles, K) ->
    MaxHeap0 = gb_trees:empty(),
    MaxHeap1 = lists:foldl(
        fun(Pile, AccHeap) ->
            Count = gb_trees:get(Pile, AccHeap, 0),
            gb_trees:update(Pile, Count + 1, AccHeap)
        end,
        MaxHeap0,
        Piles
    ),

    FinalHeap = remove_stones_loop(K, MaxHeap1),

    gb_trees:fold(
        fun(PileSize, Count, Acc) ->
            Acc + PileSize * Count
        end,
        0,
        FinalHeap
    ).

remove_stones_loop(0, MaxHeap) ->
    MaxHeap;
remove_stones_loop(K, MaxHeap) when K > 0 ->
    case gb_trees:is_empty(MaxHeap) of
        true ->
            MaxHeap;
        false ->
            {MaxPileSize, Count} = gb_trees:largest(MaxHeap),

            UpdatedHeap1 = 
                if Count - 1 == 0 ->
                    gb_trees:delete(MaxPileSize, MaxHeap);
                true ->
                    gb_trees:update(MaxPileSize, Count - 1, MaxHeap)
                end,

            NewPileSize = MaxPileSize - (MaxPileSize div 2),

            UpdatedHeap2 = 
                if NewPileSize > 0 ->
                    NewCount = gb_trees:get(NewPileSize, UpdatedHeap1, 0),
                    gb_trees:update(NewPileSize, NewCount + 1, UpdatedHeap1);
                true ->
                    UpdatedHeap1
                end,

            remove_stones_loop(K - 1, UpdatedHeap2)
    end.