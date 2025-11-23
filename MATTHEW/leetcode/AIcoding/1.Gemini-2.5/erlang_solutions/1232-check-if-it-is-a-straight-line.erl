-module(solution).
-export([checkStraightLine/1]).

checkStraightLine(Coordinates) ->
    case Coordinates of
        [[X1, Y1], [X2, Y2] | Rest] ->
            % Calculate reference differences using the first two points
            DyRef = Y2 - Y1,
            DxRef = X2 - X1,
            % Iterate through the rest of the points to check collinearity
            check_collinearity(Rest, X1, Y1, DyRef, DxRef);
        _ ->
            % This case handles lists with fewer than 2 elements, though constraints
            % guarantee at least 2. For exactly 2 points, Rest will be [],
            % and check_collinearity([], ...) will correctly return true.
            true
    end.

check_collinearity([], _X1, _Y1, _DyRef, _DxRef) ->
    true; % All points checked and found to be collinear
check_collinearity([[Xi, Yi] | Rest], X1, Y1, DyRef, DxRef) ->
    % Calculate differences for the current point relative to the first point
    DyI = Yi - Y1,
    DxI = Xi - X1,
    % Check the collinearity condition: (Y2-Y1)*(X3-X1) == (Y3-Y1)*(X2-X1)
    % This avoids division and handles vertical lines correctly.
    if
        DyRef * DxI == DyI * DxRef ->
            % If collinear, continue checking the rest of the points
            check_collinearity(Rest, X1, Y1, DyRef, DxRef);
        true ->
            % If not collinear, return false immediately
            false
    end.