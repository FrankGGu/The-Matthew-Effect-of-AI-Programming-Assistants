-module(solution).
-export([merge_k_lists/1]).

-record(node, {val, next}).

merge_k_lists(Lists) ->
    {ok, MinHeap} = heap:new(),
    lists:foreach(fun(X) -> case X of
        [] -> ok;
        [H|_] -> heap:insert(MinHeap, H)
    end end, Lists),
    merge(MinHeap).

merge(MinHeap) ->
    case heap:empty(MinHeap) of
        true -> [];
        false ->
            {Val, NextMinHeap} = heap:extract_min(MinHeap),
            [Val | merge(NextMinHeap)]
    end.

-module(heap).
-export([new/0, insert/2, extract_min/1, empty/1]).

-record(heap, {elements = []}).

new() -> {ok, #heap{}}.

insert({ok, H}, Val) ->
    NewElements = [Val | H#heap.elements],
    {ok, #heap{elements = lists:sort(NewElements)}}.

extract_min(#heap{elements = []}) -> 
    {undefined, #heap{elements = []}};
extract_min(#heap{elements = [Min | Rest]}) ->
    {Min, #heap{elements = Rest}}.

empty(#heap{elements = []}) -> true;
empty(_) -> false.