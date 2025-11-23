-module(minimize_max_edge_weight).
-export([minimize_max_edge/2]).

minimize_max_edge(Edges, N) ->
    lists:sort(Edges),
    min_edge(Edges, N, 0).

min_edge([], _, Acc) -> Acc;
min_edge([H | T], N, Acc) ->
    {U, V} = H,
    case find_root(U, N) of
        U ->
            case find_root(V, N) of
                V -> min_edge(T, N, max(Acc, H));
                _ -> min_edge(T, N, Acc)
            end;
        _ ->
            case find_root(V, N) of
                V -> min_edge(T, N, max(Acc, H));
                _ -> min_edge(T, N, Acc)
            end
    end.

find_root(X, N) ->
    find_root(X, N, dict:from_list([{I, I} || I <- lists:seq(1, N)])).

find_root(X, N, Parent) ->
    case dict:is_key(X, Parent) of
        true ->
            case dict:fetch(X, Parent) of
                X -> X;
                P ->
                    Root = find_root(P, N, Parent),
                    dict:store(X, Root, Parent),
                    Root
            end;
        false -> X
    end.