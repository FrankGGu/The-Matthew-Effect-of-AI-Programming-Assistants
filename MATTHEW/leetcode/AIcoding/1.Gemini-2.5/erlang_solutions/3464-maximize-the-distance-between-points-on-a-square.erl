-module(solution).
-export([max_distance/1]).

max_distance(Points) ->
    Pairs = all_pairs(Points),
    MaxSquaredDistance = lists:foldl(
        fun([P1, P2], Acc) ->
            SquaredDist = calculate_squared_distance(P1, P2),
            max(Acc, SquaredDist)
        end,
        0,
        Pairs
    ),
    math:sqrt(MaxSquaredDistance).

all_pairs(Points) ->
    all_pairs(Points, []).

all_pairs([], Acc) ->
    Acc;
all_pairs([H|T], Acc) ->
    NewPairs = [[H, P] || P <- T],
    all_pairs(T, Acc ++ NewPairs).

calculate_squared_distance([X1, Y1], [X2, Y2]) ->
    DX = X2 - X1,
    DY = Y2 - Y1,
    DX*DX + DY*DY.