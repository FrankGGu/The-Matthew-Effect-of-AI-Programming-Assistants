-module(solution).
-export([maxDistToClosestPerson/1]).

maxDistToClosestPerson(Seats) ->
    N = length(Seats),
    Ones = find_ones_indices(Seats, 1, []),

    Dist1 = hd(Ones) - 1,

    Dist2 = N - hd(lists:reverse(Ones)),

    Dist3 = calculate_max_mid_dist(Ones, 0),

    lists:max([Dist1, Dist2, Dist3]).

find_ones_indices([], _Idx, Acc) -> lists:reverse(Acc);
find_ones_indices([1|T], Idx, Acc) -> find_ones_indices(T, Idx + 1, [Idx|Acc]);
find_ones_indices([0|T], Idx, Acc) -> find_ones_indices(T, Idx + 1, Acc).

calculate_max_mid_dist([_], MaxDist) -> MaxDist;
calculate_max_mid_dist([P1, P2 | Rest], CurrentMax) ->
    Dist = (P2 - P1) div 2,
    NewMax = max(CurrentMax, Dist),
    calculate_max_mid_dist([P2 | Rest], NewMax).