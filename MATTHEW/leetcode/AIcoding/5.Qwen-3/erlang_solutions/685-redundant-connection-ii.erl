-module(redundant_connection_ii).
-export([find_redundant_connection/1]).

find_redundant_connection(Edges) ->
    Nodes = lists:usort(lists:flatten(Edges)),
    Parent = maps:new(),
    Rank = maps:new(),
    {_, Result} = lists:foldl(fun(Edge, {ParentAcc, RankAcc}) ->
        [U, V] = Edge,
        case find(U, ParentAcc) of
            U ->
                case find(V, ParentAcc) of
                    V -> {ParentAcc, [Edge | RankAcc]};
                    _ -> {union(U, V, ParentAcc, RankAcc), RankAcc}
                end;
            _ ->
                {union(U, V, ParentAcc, RankAcc), RankAcc}
        end
    end, {Parent, Rank}, Edges),
    lists:last(Result).

find(X, Parent) ->
    case maps:get(X, Parent, X) of
        X -> X;
        P -> find(P, Parent)
    end.

union(X, Y, Parent, Rank) ->
    PX = find(X, Parent),
    PY = find(Y, Parent),
    if
        PX == PY -> Parent;
        true ->
            if
                maps:get(PX, Rank, 0) >= maps:get(PY, Rank, 0) ->
                    maps:put(PY, PX, maps:put(PX, maps:get(PX, Rank, 0) + 1, Parent));
                true ->
                    maps:put(PX, PY, maps:put(PY, maps:get(PY, Rank, 0) + 1, Parent))
            end
    end.