-module(solution).
-export([distance_limited_paths_exist/3]).

distance_limited_paths_exist(N, EdgeList, Queries) ->
    Parent = array:new([{size, N}, {default, -1}]),
    Rank = array:new([{size, N}, {default, 1}]),
    SortedEdges = lists:sort(fun([U1, V1, W1], [U2, V2, W2]) -> W1 =< W2 end, EdgeList),
    SortedQueries = lists:zip(lists:seq(0, length(Queries) - 1), Queries),
    SortedQueriesByLimit = lists:sort(fun({_, [_, _, L1]}, {_, [_, _, L2]}) -> L1 =< L2 end, SortedQueries),
    Result = array:new([{size, length(Queries)}, {default, false}]),
    {_, Result1} = process_queries(SortedEdges, SortedQueriesByLimit, Parent, Rank, Result),
    lists:map(fun(I) -> array:get(I, Result1) end, lists:seq(0, length(Queries) - 1)).

process_queries([], Queries, _Parent, _Rank, Result) ->
    {Queries, Result};
process_queries(Edges, [], _Parent, _Rank, Result) ->
    {[], Result};
process_queries([[U, V, W] | RestEdges], [{Idx, [P, Q, Limit]} | RestQueries], Parent, Rank, Result) when W < Limit ->
    Union(Parent, Rank, U, V),
    process_queries(RestEdges, [{Idx, [P, Q, Limit]} | RestQueries], Parent, Rank, Result);
process_queries(Edges, [{Idx, [P, Q, Limit]} | RestQueries], Parent, Rank, Result) ->
    Result1 = case find(Parent, P) =:= find(Parent, Q) of
        true -> array:set(Idx, true, Result);
        false -> array:set(Idx, false, Result)
    end,
    process_queries(Edges, RestQueries, Parent, Rank, Result1).

find(Parent, X) ->
    case array:get(X, Parent) of
        -1 -> X;
        P ->
            Root = find(Parent, P),
            array:set(X, Root, Parent),
            Root
    end.

union(Parent, Rank, X, Y) ->
    RootX = find(Parent, X),
    RootY = find(Parent, Y),
    if
        RootX =/= RootY ->
            RankX = array:get(RootX, Rank),
            RankY = array:get(RootY, Rank),
            if
                RankX > RankY ->
                    array:set(RootY, RootX, Parent),
                    array:set(RootX, RankX + RankY, Rank);
                true ->
                    array:set(RootX, RootY, Parent),
                    array:set(RootY, RankX + RankY, Rank)
            end;
        true -> ok
    end.