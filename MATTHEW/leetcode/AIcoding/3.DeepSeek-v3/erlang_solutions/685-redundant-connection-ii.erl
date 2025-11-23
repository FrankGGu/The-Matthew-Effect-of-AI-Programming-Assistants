findRedundantDirectedConnection(Edges) ->
    N = length(Edges),
    Parent = lists:seq(0, N),
    Candidate1 = [-1, -1],
    Candidate2 = [-1, -1],
    {Parent1, Candidate1, Candidate2} = find_parent_candidates(Edges, Parent, Candidate1, Candidate2),
    case {Candidate1, Candidate2} of
        {[-1, -1], [-1, -1]} ->
            find_redundant_connection(Edges, Parent1);
        _ ->
            case is_cycle(Edges, Parent1, Candidate2) of
                true -> Candidate1;
                false -> Candidate2
            end
    end.

find_parent_candidates([], Parent, C1, C2) ->
    {Parent, C1, C2};
find_parent_candidates([[U, V] | Rest], Parent, C1, C2) ->
    case lists:nth(V, Parent) of
        0 ->
            NewParent = setelement(V, Parent, U),
            find_parent_candidates(Rest, NewParent, C1, C2);
        _ ->
            C1New = [lists:nth(V, Parent), V],
            C2New = [U, V],
            find_parent_candidates(Rest, Parent, C1New, C2New)
    end.

find_redundant_connection(Edges, Parent) ->
    lists:foldl(fun([U, V], Acc) ->
        RootU = find_root(U, Parent),
        case RootU =:= V of
            true -> [U, V];
            false -> setelement(V, Parent, U), Acc
        end
    end, [], Edges).

find_root(U, Parent) ->
    case lists:nth(U, Parent) of
        0 -> U;
        P -> find_root(P, Parent)
    end.

is_cycle(Edges, Parent, [U, V]) ->
    RootU = find_root(U, Parent),
    RootV = find_root(V, Parent),
    RootU =:= RootV.