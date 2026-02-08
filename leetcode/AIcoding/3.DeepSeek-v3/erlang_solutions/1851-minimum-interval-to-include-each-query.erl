-module(solution).
-export([min_interval/2]).

min_interval(Intervals, Queries) ->
    SortedIntervals = lists:sort(fun([A, B], [C, D]) -> 
        case A =:= C of
            true -> B < D;
            false -> A < C
        end
    end, Intervals),
    Qs = lists:zip(Queries, lists:seq(1, length(Queries))),
    SortedQueries = lists:sort(fun({Q1, _}, {Q2, _}) -> Q1 < Q2 end, Qs),
    Heap = [],
    Result = array:new(length(Queries), {_, _, _, Result1} = process_queries(SortedIntervals, SortedQueries, Heap, Result),
    lists:map(fun(I) -> array:get(I, Result1) end, lists:seq(0, length(Queries) - 1)).

process_queries([], [], _, Result) -> {[], [], [], Result};
process_queries(Intervals, [], _, Result) -> {Intervals, [], [], Result};
process_queries([], Queries, Heap, Result) -> {[], Queries, Heap, Result};
process_queries([[A, B] | RestIntervals], [{Q, Idx} | RestQueries], Heap, Result) when Q >= A ->
    NewHeap = heap:insert(Heap, {B - A + 1, B}),
    process_queries(RestIntervals, [{Q, Idx} | RestQueries], NewHeap, Result);
process_queries(Intervals, [{Q, Idx} | RestQueries], Heap, Result) ->
    {NewHeap, Min} = clean_heap(Heap, Q),
    NewResult = array:set(Idx, Min, Result),
    process_queries(Intervals, RestQueries, NewHeap, NewResult).

clean_heap(Heap, Q) ->
    case heap:is_empty(Heap) of
        true -> {Heap, -1};
        false ->
            {Size, End} = heap:peek(Heap),
            if
                End >= Q -> {Heap, Size};
                true -> 
                    {_, NewHeap} = heap:pop(Heap),
                    clean_heap(NewHeap, Q)
            end
    end.