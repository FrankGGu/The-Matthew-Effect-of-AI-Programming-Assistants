-module(redundant_connection).
-export([find_redundant_connection/1]).

find_redundant_connection(Edges) ->
    N = length(Edges);
    Parent = lists:seq(1, N),

    find(X, Parent) ->
        if X =:= lists:nth(X, Parent) then
            X
        else
            P = find(lists:nth(X, Parent), Parent),
            lists:nth(X, Parent) ! P,
            P
        end
    end,

    union(X, Y, Parent) ->
        RootX = find(X, Parent),
        RootY = find(Y, Parent),
        if RootX =/= RootY then
            lists:nth(RootX, Parent) ! RootY,
            true
        else
            false
        end
    end,

    lists:foldl(fun([U, V], Acc) ->
                       case union(U, V, Acc) of
                           true ->
                               Acc;
                           false ->
                               [U, V]
                       end
                   end, Parent, Edges).