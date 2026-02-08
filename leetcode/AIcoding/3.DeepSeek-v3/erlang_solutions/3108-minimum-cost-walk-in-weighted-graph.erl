-module(solution).
-export([minimum_cost/3]).

minimum_cost(N, Edges, Query) ->
    Parent = lists:seq(0, N - 1),
    Rank = lists:duplicate(N, 0),
    {Parent1, _} = lists:foldl(fun([U, V, W], {P, R}) ->
        union(U, V, W, P, R)
    end, {Parent, Rank}, Edges),
    [find_cost(A, B, Parent1) || [A, B] <- Query].

find_cost(A, B, Parent) ->
    case find(A, Parent) of
        {RootA, CostA} ->
            case find(B, Parent) of
                {RootB, CostB} ->
                    if RootA =:= RootB -> CostA bxor CostB;
                       true -> -1
                    end;
                _ -> -1
            end;
        _ -> -1
    end.

find(X, Parent) ->
    find(X, Parent, 0).

find(X, Parent, Cost) ->
    case lists:nth(X + 1, Parent) of
        X -> {X, Cost};
        P ->
            {Root, Pcost} = find(P, Parent),
            {Root, Cost bxor Pcost}
    end.

union(U, V, W, Parent, Rank) ->
    {RootU, CostU} = find(U, Parent),
    {RootV, CostV} = find(V, Parent),
    if RootU =:= RootV -> {Parent, Rank};
       true ->
            case lists:nth(RootU + 1, Rank) < lists:nth(RootV + 1, Rank) of
                true ->
                    Parent1 = setelement(RootU + 1, list_to_tuple(Parent), RootV),
                    Parent2 = setelement(RootU + 1, list_to_tuple(Parent1), CostU bxor CostV bxor W),
                    {tuple_to_list(Parent2), Rank};
                false ->
                    Parent1 = setelement(RootV + 1, list_to_tuple(Parent), RootU),
                    Parent2 = setelement(RootV + 1, list_to_tuple(Parent1), CostU bxor CostV bxor W),
                    Rank1 = if lists:nth(RootU + 1, Rank) =:= lists:nth(RootV + 1, Rank) ->
                                    setelement(RootU + 1, list_to_tuple(Rank), lists:nth(RootU + 1, Rank) + 1);
                                true -> Rank
                             end,
                    {tuple_to_list(Parent2), Rank1}
            end
    end.