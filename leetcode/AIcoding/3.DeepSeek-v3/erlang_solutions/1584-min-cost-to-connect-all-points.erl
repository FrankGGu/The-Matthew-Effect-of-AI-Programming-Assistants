-spec min_cost_connect_points(Points :: [[integer()]]) -> integer().
min_cost_connect_points(Points) ->
    N = length(Points),
    if N == 0 -> 0;
       true ->
            Edges = generate_edges(Points),
            Parent = lists:seq(0, N-1),
            Kruskal = kruskal(Edges, Parent, N, 0, 0),
            Kruskal
    end.

generate_edges(Points) ->
    N = length(Points),
    Edges = lists:flatten([ [ {abs(lists:nth(1, lists:nth(I+1, Points)) - lists:nth(1, lists:nth(J+1, Points))) + 
                               abs(lists:nth(2, lists:nth(I+1, Points)) - lists:nth(2, lists:nth(J+1, Points))), I, J} 
                             || I <- lists:seq(0, N-2), J <- lists:seq(I+1, N-1) ]),
    lists:sort(Edges).

kruskal([], _, _, Cost, Count) when Count == 0 -> Cost;
kruskal([], _, _, Cost, _) -> Cost;
kruskal([{D, U, V} | Rest], Parent, N, Cost, Count) ->
    RootU = find(U, Parent),
    RootV = find(V, Parent),
    if RootU =/= RootV ->
           NewParent = union(RootU, RootV, Parent),
           kruskal(Rest, NewParent, N, Cost + D, Count - 1);
       true ->
           kruskal(Rest, Parent, N, Cost, Count)
    end.

find(U, Parent) ->
    if lists:nth(U+1, Parent) == U -> U;
       true -> find(lists:nth(U+1, Parent), Parent)
    end.

union(U, V, Parent) ->
    NewParent = setelement(U+1, Parent, V),
    NewParent.