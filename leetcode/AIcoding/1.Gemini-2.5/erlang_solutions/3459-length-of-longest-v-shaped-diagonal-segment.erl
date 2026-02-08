-module(solution).
-export([longest_v_shaped_diagonal_segment/1]).

longest_v_shaped_diagonal_segment(RawPoints) ->
    % Sort points by x-coordinate, then by y-coordinate for tie-breaking.
    % This ensures x1 < x2 < x3 naturally when iterating for P1, P2, P3.
    Points = lists:sort(fun([X1,Y1],[X2,Y2]) ->
                                if X1 == X2 -> Y1 < Y2;
                                   true -> X1 < X2
                                end
                        end, RawPoints),

    N = length(Points),

    % A V-shaped segment requires at least 3 distinct points.
    if N < 3 -> 0;
       true ->
            % Convert the sorted list of points to an array for O(1) access.
            PointsArray = array:from_list(Points),
            MaxLen = 0,

            % Iterate through each point, considering it as P2 (the vertex of the V-shape).
            % The index I for P2 ranges from 0 to N-1.
            % P1 candidates will have index J < I.
            % P3 candidates will have index K > I.
            lists:foldl(fun(I, CurrentMaxLen) ->
                P2 = array:get(I, PointsArray), % P2 = [X2, Y2]
                [X2, Y2] = P2,

                % Calculate MaxLenLeftUp: maximum (X2 - X1) for an upward V's left arm (P1-P2)
                % P1 must satisfy: X1 < X2, Y1 > Y2, and P1-P2 is diagonal.
                MaxLenLeftUp = lists:foldl(fun(J, AccMax) ->
                    P1 = array:get(J, PointsArray), % P1 = [X1, Y1]
                    [X1, Y1] = P1,

                    % X1 < X2 is guaranteed by sorting and J < I.
                    % Check if P1-P2 is a diagonal segment and Y1 > Y2.
                    if abs(X1 - X2) == abs(Y1 - Y2) andalso Y1 > Y2 ->
                        max(AccMax, X2 - X1);
                       true ->
                        AccMax
                    end
                end, 0, lists:seq(0, I - 1)), % Iterate J from 0 to I-1 for P1 candidates

                % Calculate MaxLenLeftDown: maximum (X2 - X1) for a downward V's left arm (P1-P2)
                % P1 must satisfy: X1 < X2, Y1 < Y2, and P1-P2 is diagonal.
                MaxLenLeftDown = lists:foldl(fun(J, AccMax) ->
                    P1 = array:get(J, PointsArray), % P1 = [X1, Y1]
                    [X1, Y1] = P1,

                    % X1 < X2 is guaranteed by sorting and J < I.
                    % Check if P1-P2 is a diagonal segment and Y1 < Y2.
                    if abs(X1 - X2) == abs(Y1 - Y2) andalso Y1 < Y2 ->
                        max(AccMax, X2 - X1);
                       true ->
                        AccMax
                    end
                end, 0, lists:seq(0, I - 1)), % Iterate J from 0 to I-1 for P1 candidates

                % Calculate MaxLenRightUp: maximum (X3 - X2) for an upward V's right arm (P2-P3)
                % P3 must satisfy: X3 > X2, Y2 < Y3, and P2-P3 is diagonal.
                MaxLenRightUp = lists:foldl(fun(K, AccMax) ->
                    P3 = array:get(K, PointsArray), % P3 = [X3, Y3]
                    [X3, Y3] = P3,

                    % X3 > X2 is guaranteed by sorting and K > I.
                    % Check if P2-P3 is a diagonal segment and Y2 < Y3.
                    if abs(X2 - X3) == abs(Y2 - Y3) andalso Y2 < Y3 ->
                        max(AccMax, X3 - X2);
                       true ->
                        AccMax
                    end
                end, 0, lists:seq(I + 1, N - 1)), % Iterate K from I+1 to N-1 for P3 candidates

                % Calculate MaxLenRightDown: maximum (X3 - X2) for a downward V's right arm (P2-P3)
                % P3 must satisfy: X3 > X2, Y2 > Y3, and P2-P3 is diagonal.
                MaxLenRightDown = lists:foldl(fun(K, AccMax) ->
                    P3 = array:get(K, PointsArray), % P3 = [X3, Y3]
                    [X3, Y3] = P3,

                    % X3 > X2 is guaranteed by sorting and K > I.
                    % Check if P2-P3 is a diagonal segment and Y2 > Y3.
                    if abs(X2 - X3) == abs(Y2 - Y3) andalso Y2 > Y3 ->
                        max(AccMax, X3 - X2);
                       true ->
                        AccMax
                    end
                end, 0, lists:seq(I + 1, N - 1)), % Iterate K from I+1 to N-1 for P3 candidates

                % Update the overall maximum length found so far.
                % An upward V-shape uses MaxLenLeftUp and MaxLenRightUp.
                % A downward V-shape uses MaxLenLeftDown and MaxLenRightDown.
                CurrentMaxLen1 = max(CurrentMaxLen, MaxLenLeftUp + MaxLenRightUp),
                max(CurrentMaxLen1, MaxLenLeftDown + MaxLenRightDown)

            end, MaxLen, lists:seq(0, N - 1)) % Iterate I from 0 to N-1 for P2 candidates
    end).