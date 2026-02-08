-module(solution).
-export([maximum_weight/2]).

maximum_weight(N, Edges) ->
    Parent = lists:seq(0, N - 1),
    {Sum, _} = lists:foldl(fun({U, V, W}, {Acc, P}) ->
        RootU = find(U, P),
        RootV = find(V, P),
        case RootU =/= RootV of
            true ->
                NewP = union(RootU, RootV, P),
                {Acc + W, NewP};
            false ->
                {Acc, P}
        end
    end, {0, Parent}, lists:sort(fun({_, _, W1}, {_, _, W2}) -> W1 > W2 end, Edges))),
    Sum.

find(U, Parent) ->
    case lists:nth(U + 1, Parent) of
        U -> U;
        P -> find(P, Parent)
    end.

union(U, V, Parent) ->
    RootU = find(U, Parent),
    RootV = find(V, Parent),
    case RootU =/= RootV of
        true -> 
            NewParent = lists:sublist(Parent, RootV) ++ [RootU] ++ lists:nthtail(RootV + 1, Parent),
            NewParent;
        false -> Parent
    end.