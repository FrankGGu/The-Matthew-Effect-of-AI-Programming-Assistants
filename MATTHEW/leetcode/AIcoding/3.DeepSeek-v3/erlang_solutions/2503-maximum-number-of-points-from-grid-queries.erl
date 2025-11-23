-module(solution).
-export([max_points/2]).

max_points(Grid, Queries) ->
    M = length(Grid),
    N = length(hd(Grid)),
    Q = length(Queries),
    SortedQueries = lists:zip(lists:seq(0, Q - 1), Queries),
    SortedQueries1 = lists:keysort(2, SortedQueries),
    Heap = heap:new([{Grid, 0, 0}]),
    Visited = sets:from_list([{0, 0}]),
    {Result, _, _} = process_queries(SortedQueries1, Heap, Visited, Grid, M, N, array:new(Q, {default, 0}), 0),
    SortedResult = lists:keysort(1, Result),
    [Count || {_, Count} <- SortedResult].

process_queries([], _, _, _, _, _, Result, _) ->
    {array:to_list(Result), 0, 0};
process_queries([{Idx, Q} | Rest], Heap, Visited, Grid, M, N, Result, Max) ->
    case heap:is_empty(Heap) of
        true ->
            NewResult = array:set(Idx, Max, Result),
            process_queries(Rest, Heap, Visited, Grid, M, N, NewResult, Max);
        false ->
            {Min, NewHeap} = heap:take(Heap),
            if
                Min >= Q ->
                    NewResult = array:set(Idx, Max, Result),
                    NewHeap1 = heap:insert(Min, NewHeap),
                    process_queries(Rest, NewHeap1, Visited, Grid, M, N, NewResult, Max);
                true ->
                    {X, Y} = Min,
                    NewMax = Max + 1,
                    Neighbors = [{X + 1, Y}, {X - 1, Y}, {X, Y + 1}, {X, Y - 1}],
                    {NewHeap1, NewVisited} = add_neighbors(Neighbors, NewHeap, Visited, Grid, M, N),
                    process_queries([{Idx, Q} | Rest], NewHeap1, NewVisited, Grid, M, N, Result, NewMax)
            end
    end.

add_neighbors([], Heap, Visited, _, _, _) ->
    {Heap, Visited};
add_neighbors([{X, Y} | Rest], Heap, Visited, Grid, M, N) ->
    case X >= 0 andalso X < M andalso Y >= 0 andalso Y < N of
        false ->
            add_neighbors(Rest, Heap, Visited, Grid, M, N);
        true ->
            case sets:is_element({X, Y}, Visited) of
                true ->
                    add_neighbors(Rest, Heap, Visited, Grid, M, N);
                false ->
                    Val = lists:nth(Y + 1, lists:nth(X + 1, Grid)),
                    NewHeap = heap:insert(Val, Heap),
                    NewVisited = sets:add_element({X, Y}, Visited),
                    add_neighbors(Rest, NewHeap, NewVisited, Grid, M, N)
            end
    end.