-module(solution).
-export([distance_limited_paths_exist/3]).

distance_limited_paths_exist(N, EdgeList, Queries) ->
    Parent = array:new([{size, N}, {default, -1}]),
    SortedEdges = lists:sort(fun([A1, B1, W1], [A2, B2, W2]) -> W1 =< W2 end, EdgeList),
    ProcessedQueries = lists:zip(lists:seq(0, length(Queries) - 1), Queries),
    SortedQueries = lists:sort(fun({_, [_, _, L1]}, {_, [_, _, L2]}) -> L1 =< L2 end, ProcessedQueries),
    Result = array:new([{size, length(Queries)}, {default, false}]),
    {_, FinalResult} = process_queries(SortedEdges, SortedQueries, Parent, Result),
    array:to_list(FinalResult).

process_queries(Edges, [], _Parent, Result) ->
    {Edges, Result};
process_queries([Edge | RestEdges], [{Idx, [P, Q, Limit]} | RestQueries], Parent, Result) ->
    [A, B, W] = Edge,
    case W < Limit of
        true ->
            Union(Parent, A, B),
            process_queries(RestEdges, [{Idx, [P, Q, Limit]} | RestQueries], Parent, Result);
        false ->
            IsConnected = find(Parent, P) =:= find(Parent, Q),
            NewResult = array:set(Idx, IsConnected, Result),
            process_queries([Edge | RestEdges], RestQueries, Parent, NewResult)
    end;
process_queries([], [{Idx, [P, Q, _]} | RestQueries], Parent, Result) ->
    IsConnected = find(Parent, P) =:= find(Parent, Q),
    NewResult = array:set(Idx, IsConnected, Result),
    process_queries([], RestQueries, Parent, NewResult).

find(Parent, X) ->
    case array:get(X, Parent) of
        -1 -> X;
        P ->
            Root = find(Parent, P),
            array:set(X, Root, Parent),
            Root
    end.

union(Parent, X, Y) ->
    RootX = find(Parent, X),
    RootY = find(Parent, Y),
    if
        RootX =/= RootY -> array:set(RootY, RootX, Parent);
        true -> Parent
    end.