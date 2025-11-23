-module(solution).
-export([calculateMinimumHP/1]).

calculateMinimumHP(Dungeon) ->
    M = length(Dungeon),
    N = length(hd(Dungeon)),
    DP = lists:duplicate(N + 1, 1000000),
    DP1 = setelement(N, DP, 1),
    calculateMinimumHP(Dungeon, M, N, DP1).

calculateMinimumHP(Dungeon, M, N, DP) ->
    calculateMinimumHP(Dungeon, M, N, M, DP).

calculateMinimumHP(_, _, _, 0, DP) ->
    element(1, DP);
calculateMinimumHP(Dungeon, M, N, I, DP) ->
    Row = lists:nth(I, Dungeon),
    NewDP = calculateRow(Row, N, DP, N, []),
    calculateMinimumHP(Dungeon, M, N, I - 1, NewDP).

calculateRow(_, 0, DP, _, Acc) ->
    list_to_tuple(lists:reverse(Acc));
calculateRow(Row, J, DP, N, Acc) ->
    Val = lists:nth(J, Row),
    Min = min(element(J + 1, DP), hd(Acc)),
    Need = max(1, Min - Val),
    calculateRow(Row, J - 1, DP, N, [Need | Acc]).