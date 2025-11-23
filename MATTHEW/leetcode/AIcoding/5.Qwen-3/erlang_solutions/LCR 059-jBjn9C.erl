-module(kth_largest).
-export([new/1, add/2]).

-record(state, {k, heap}).

new(K) ->
    {ok, Heap} = erlheap:new(min),
    #state{k = K, heap = Heap}.

add(Num, State) ->
    #state{k = K, heap = Heap} = State,
    {ok, NewHeap} = erlheap:insert(Heap, Num),
    case erlheap:size(NewHeap) of
        Size when Size > K ->
            {ok, _} = erlheap:extract_min(NewHeap),
            {ok, NewHeap};
        _ ->
            {ok, NewHeap}
    end.