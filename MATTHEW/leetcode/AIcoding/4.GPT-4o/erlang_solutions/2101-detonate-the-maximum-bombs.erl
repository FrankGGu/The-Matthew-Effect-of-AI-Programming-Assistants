-module(solution).
-export([maximumDetonations/1]).

maximumDetonations(Bombs) ->
    N = length(Bombs),
    MaxDetonations = lists:foldl(fun(I, Acc) -> 
        Detonations = countDetonations(Bombs, I, N),
        max(Detonations, Acc)
    end, 0, lists:seq(1, N)),
    MaxDetonations.

countDetonations(Bombs, I, N) ->
    Visited = lists:duplicate(N, false),
    countDetonationsHelper(Bombs, I, Visited).

countDetonationsHelper(Bombs, I, Visited) ->
    Visited1 = lists:map(fun(X) -> X end, Visited),
    Visited1 = lists:replace(Visited1, I - 1, true),
    Queue = [I],
    DetonatedCount = countDetonationsInQueue(Bombs, Queue, Visited1, 1).

countDetonationsInQueue(_, [], Visited, Count) ->
    Count;
countDetonationsInQueue(Bombs, [H | T], Visited, Count) ->
    NewVisited = lists:foldl(fun(Index, AccVisited) ->
        if
            AccVisited =:= Visited ->
                AccVisited;
            true ->
                Bomb = lists:nth(Index, Bombs),
                {X, Y, R} = {lists:nth(1, Bomb), lists:nth(2, Bomb), lists:nth(3, Bomb)},
                if
                    distance(X, Y, Bombs, H) =< R ->
                        AccVisited = lists:replace(AccVisited, Index - 1, true),
                        AccVisited;
                    true ->
                        AccVisited
                end
        end, Visited, lists:seq(1, length(Bombs))),
    countDetonationsInQueue(Bombs, T, NewVisited, Count + 1).

distance(X, Y, Bombs, H) ->
    Bomb = lists:nth(H, Bombs),
    X1 = lists:nth(1, Bomb),
    Y1 = lists:nth(2, Bomb),
    sqrt((X1 - X) ^ 2 + (Y1 - Y) ^ 2).