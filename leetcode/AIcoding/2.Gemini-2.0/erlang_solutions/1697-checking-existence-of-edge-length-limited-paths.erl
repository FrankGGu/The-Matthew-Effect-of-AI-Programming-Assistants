-module(edge_length_limited_paths).
-export([distance_limited_paths_exist/2]).

distance_limited_paths_exist(N, EdgeList, Queries) ->
    UF = uf_create(N),
    SortedEdges = lists:sort(fun({_, _, W1}, {_, _, W2}) -> W1 < W2 end, EdgeList),
    distance_limited_paths_exist(Queries, SortedEdges, UF, []).

distance_limited_paths_exist([], _, _, Acc) ->
    lists:reverse(Acc);
distance_limited_paths_exist([Query | RestQueries], SortedEdges, UF, Acc) ->
    {P, Q, Limit} = Query,
    {UpdatedSortedEdges, UpdatedUF} = process_edges(SortedEdges, Limit, UF),
    Connected = uf_connected(UpdatedUF, P, Q),
    distance_limited_paths_exist(RestQueries, UpdatedSortedEdges, UpdatedUF, [Connected | Acc]).

process_edges([], _, UF) ->
    {[], UF};
process_edges(Edges, Limit, UF) ->
    process_edges(Edges, Limit, UF, []).

process_edges([], _, UF, Acc) ->
  {lists:reverse(Acc), UF};
process_edges([{U, V, W} | RestEdges], Limit, UF, Acc) when W < Limit ->
    UpdatedUF = uf_union(UF, U, V),
    process_edges(RestEdges, Limit, UpdatedUF, Acc);
process_edges([{U, V, W} | RestEdges], Limit, UF, Acc) ->
    {[ {U,V,W} |RestEdges], UF}.

-record(uf, {parent, size}).

uf_create(N) ->
    Parent = lists:seq(0, N - 1),
    Size = lists:duplicate(N, 1),
    #uf{parent = Parent, size = Size}.

uf_find(UF = #uf{parent = Parent}, X) ->
    case lists:nth(X + 1, Parent) of
        X ->
            X;
        Y ->
            Root = uf_find(UF, Y),
            update_parent(UF, X, Root)
    end.

update_parent(UF = #uf{parent = Parent}, X, Root) ->
  UpdatedParent = lists:update(X+1, Root, Parent),
  UF#uf{parent = UpdatedParent}.

uf_union(UF = #uf{parent = Parent, size = Size}, X, Y) ->
    RootX = uf_find(UF, X),
    RootY = uf_find(UF, Y),
    if RootX == RootY then
        UF
    else
        SizeX = lists:nth(RootX + 1, Size),
        SizeY = lists:nth(RootY + 1, Size),
        if SizeX < SizeY then
            UpdatedParent = lists:update(RootX + 1, RootY, Parent),
            UpdatedSize = lists:update(RootY + 1, SizeX + SizeY, Size),
            UF#uf{parent = UpdatedParent, size = UpdatedSize}
        else
            UpdatedParent = lists:update(RootY + 1, RootX, Parent),
            UpdatedSize = lists:update(RootX + 1, SizeX + SizeY, Size),
            UF#uf{parent = UpdatedParent, size = UpdatedSize}
        end
    end.

uf_connected(UF, X, Y) ->
    uf_find(UF, X) == uf_find(UF, Y).