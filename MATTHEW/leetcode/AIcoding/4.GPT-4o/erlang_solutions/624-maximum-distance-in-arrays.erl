-module(solution).
-export([maxDistance/2]).

maxDistance(A, B) ->
    max_distance(A, B, 0, 0, 0).

max_distance([], [], Max, _, _) -> Max;
max_distance([H1 | T1], B, Max, Min1, Max1) ->
    NewMax = max(Max, abs(H1 - Min1), abs(H1 - Max1)),
    NewMin = min(Min1, H1),
    NewMax1 = max(Max1, H1),
    max_distance(T1, B, NewMax, NewMin, NewMax1);
max_distance(A, [], Max, Min1, Max1) ->
    max_distance(A, 0, Max, Min1, Max1);
max_distance(A, [H2 | T2], Max, Min1, Max1) ->
    NewMax = max(Max, abs(H2 - Min1), abs(H2 - Max1)),
    max_distance(A, T2, NewMax, Min1, Max1).

max(A, B, C) -> max(max(A, B), C).
min(A, B) -> if A < B -> A; true -> B end.