-module(solution).
-export([find_critical_and_pseudo_critical_edges/2]).

find_critical_and_pseudo_critical_edges(N, Edges) ->
    M = length(Edges),
    IndexedEdges = lists:zip(lists:seq(0, M - 1), Edges),
    SortedEdges = lists:sort(fun({_, [U1, V1, W1]}, {_, [U2, V2, W2]}) -> 
        if W1 =:= W2 -> min(U1, V1) =< min(U2, V2); true -> W1 =< W2 end 
    end, IndexedEdges),
    OriginalMST = kruskal(N, SortedEdges, []),
    {Critical, Pseudo} = classify_edges(N, SortedEdges, OriginalMST, [], []),
    {Critical, Pseudo}.

classify_edges(_, [], _, Critical, Pseudo) ->
    {lists:sort(Critical), lists:sort(Pseudo)};
classify_edges(N, [{I, Edge}|Rest], OriginalMST, Critical, Pseudo) ->
    case kruskal(N, Rest, []) of
        OriginalMST ->
            case kruskal(N, Rest, [{I, Edge}]) of
                OriginalMST ->
                    classify_edges(N, Rest, OriginalMST, Critical, [I|Pseudo]);
                _ ->
                    classify_edges(N, Rest, OriginalMST, [I|Critical], Pseudo)
            end;
        _ ->
            classify_edges(N, Rest, OriginalMST, [I|Critical], Pseudo)
    end.

kruskal(N, Edges, ForcedEdges) ->
    Parent = array:new([{size, N}, {default, -1}]),
    {MSTWeight, UsedEdges} = kruskal_helper(Edges, ForcedEdges, Parent, 0, []),
    case length(UsedEdges) + length(ForcedEdges) =:= N - 1 of
        true -> MSTWeight;
        false -> infinity
    end.

kruskal_helper([], _, _, Weight, Used) ->
    {Weight, Used};
kruskal_helper([{I, [U, V, W]}|Rest], ForcedEdges, Parent, Weight, Used) ->
    case lists:keymember(I, 1, ForcedEdges) of
        true ->
            RootU = find(U, Parent),
            RootV = find(V, Parent),
            NewParent = case RootU of
                RootV -> Parent;
                _ -> array:set(RootV, RootU, Parent)
            end,
            kruskal_helper(Rest, ForcedEdges, NewParent, Weight + W, [{I, [U, V, W]}|Used]);
        false ->
            RootU = find(U, Parent),
            RootV = find(V, Parent),
            case RootU =:= RootV of
                true ->
                    kruskal_helper(Rest, ForcedEdges, Parent, Weight, Used);
                false ->
                    NewParent = array:set(RootV, RootU, Parent),
                    kruskal_helper(Rest, ForcedEdges, NewParent, Weight + W, [{I, [U, V, W]}|Used])
            end
    end.

find(X, Parent) ->
    case array:get(X, Parent) of
        -1 -> X;
        P ->
            Root = find(P, Parent),
            array:set(X, Root, Parent),
            Root
    end.