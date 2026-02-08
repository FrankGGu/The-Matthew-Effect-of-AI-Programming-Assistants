-module(edge_length_limited_paths).
-export([query_after_edges/2]).

query_after_edges(Edges, Queries) ->
    SortedEdges = lists:sort(Edges),
    SortedQueries = lists:sort([{QIndex, QFrom, QTo, QLimit} || {QIndex, QFrom, QTo, QLimit} <- Queries]),
    Parent = array:new(10000, {default, 0}),
    Result = array:new(length(Queries), {default, false}),
    EdgeIndex = 0,
    QueryIndex = 0,
    loop_edges(SortedEdges, SortedQueries, EdgeIndex, QueryIndex, Parent, Result).

loop_edges([], _, _, _, _, Result) -> Result;
loop_edges(SortedEdges, SortedQueries, EdgeIndex, QueryIndex, Parent, Result) ->
    if
        EdgeIndex < length(SortedEdges) andalso (QueryIndex >= length(SortedQueries) orelse element(4, lists:nth(QueryIndex, SortedQueries)) >= element(3, lists:nth(EdgeIndex, SortedEdges))) ->
            {From, To, _} = lists:nth(EdgeIndex, SortedEdges),
            Union(Parent, From, To),
            loop_edges(SortedEdges, SortedQueries, EdgeIndex + 1, QueryIndex, Parent, Result);
        QueryIndex < length(SortedQueries) ->
            {QIndex, QFrom, QTo, QLimit} = lists:nth(QueryIndex, SortedQueries),
            if
                Find(Parent, QFrom) == Find(Parent, QTo) ->
                    UpdatedResult = array:set(QIndex, true, Result),
                    loop_edges(SortedEdges, SortedQueries, EdgeIndex, QueryIndex + 1, Parent, UpdatedResult);
                true ->
                    UpdatedResult = array:set(QIndex, false, Result),
                    loop_edges(SortedEdges, SortedQueries, EdgeIndex, QueryIndex + 1, Parent, UpdatedResult)
            end;
        true ->
            Result
    end.

Union(Parent, X, Y) ->
    RootX = Find(Parent, X),
    RootY = Find(Parent, Y),
    if
        RootX /= RootY ->
            array:set(RootY, RootX, Parent);
        true ->
            Parent
    end.

Find(Parent, X) ->
    case array:get(X, Parent) of
        X -> X;
        P -> Find(Parent, P)
    end.