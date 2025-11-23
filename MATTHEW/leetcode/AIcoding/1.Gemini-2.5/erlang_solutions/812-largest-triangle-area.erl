-module(solution).
-export([largest_triangle_area/1]).

largest_triangle_area(Points) ->
    find_max_area(Points, 0.0).

find_max_area([], MaxArea) -> MaxArea;
find_max_area([P1 | RestPoints], CurrentMaxArea) ->
    MaxAreaAfterP1 = find_max_area_with_p1(P1, RestPoints, CurrentMaxArea),
    find_max_area(RestPoints, MaxAreaAfterP1).

find_max_area_with_p1(_P1, [], MaxArea) -> MaxArea;
find_max_area_with_p1(P1, [P2 | RestPointsForP3], CurrentMaxArea) ->
    MaxAreaAfterP2 = find_max_area_with_p1_p2(P1, P2, RestPointsForP3, CurrentMaxArea),
    find_max_area_with_p1(P1, RestPointsForP3, MaxAreaAfterP2).

find_max_area_with_p1_p2(_P1, _P2, [], MaxArea) -> MaxArea;
find_max_area_with_p1_p2(P1, P2, [P3 | RestPointsAfterP3], CurrentMaxArea) ->
    Area = calculate_triangle_area(P1, P2, P3),
    NewMaxArea = max(CurrentMaxArea, Area),
    find_max_area_with_p1_p2(P1, P2, RestPointsAfterP3, NewMaxArea).

calculate_triangle_area([X1, Y1], [X2, Y2], [X3, Y3]) ->
    Term1 = X1 * (Y2 - Y3),
    Term2 = X2 * (Y3 - Y1),
    Term3 = X3 * (Y1 - Y2),
    0.5 * abs(Term1 + Term2 + Term3).