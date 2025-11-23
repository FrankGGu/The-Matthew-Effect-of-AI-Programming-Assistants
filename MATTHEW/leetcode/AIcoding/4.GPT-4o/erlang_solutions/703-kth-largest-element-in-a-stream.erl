-module(kth_largest).
-export([kth_largest/2, add/2]).

-record(state, {k, min_heap}).

kth_largest(K) ->
    #state{k=K, min_heap=[]}.

add(State, Val) ->
    NewHeap = lists:append(State#state.min_heap, [Val]),
    SortedHeap = lists:sort(NewHeap),
    NewMinHeap = lists:sublist(SortedHeap, length(SortedHeap) - State#state.k + 1),
    #state{State#state | min_heap = NewMinHeap}.

get_kth_largest(State) ->
    lists:nth(1, lists:sort(State#state.min_heap)).