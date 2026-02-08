-module(kth_smallest_amount).
-export([kthSmallestAmount/2]).

kthSmallestAmount(Coins, K) ->
    SortedCoins = lists:sort(Coins),
    {ok, Heap} = erlang:heap_init(),
    erlang:heap_insert(Heap, {0, 0}),
    Visited = sets:new(),
    Visited1 = sets:add_element(0, Visited),
    kthSmallestAmountHelper(SortedCoins, K, Heap, Visited1, 0).

kthSmallestAmountHelper(_, 0, _, _, Result) ->
    Result;
kthSmallestAmountHelper(Coins, K, Heap, Visited, _) ->
    {Value, Index} = erlang:heap_pop(Heap),
    case K of
        1 -> Value;
        _ -> 
            NextIndex = Index + 1,
            NewVisited = Visited,
            lists:foreach(
                fun(I) ->
                    if I >= NextIndex ->
                        Amount = Value + lists:nth(I + 1, Coins),
                        if not sets:is_element(Amount, NewVisited) ->
                            erlang:heap_insert(Heap, {Amount, I + 1}),
                            NewVisited1 = sets:add_element(Amount, NewVisited),
                            ok;
                        true ->
                            ok
                    end
                end,
                lists:seq(NextIndex, length(Coins) - 1)
            ),
            kthSmallestAmountHelper(Coins, K - 1, Heap, NewVisited, Value)
    end.