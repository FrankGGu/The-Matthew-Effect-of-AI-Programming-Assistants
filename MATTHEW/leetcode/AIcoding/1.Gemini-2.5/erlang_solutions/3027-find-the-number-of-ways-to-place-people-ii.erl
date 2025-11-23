-module(solution).
-export([numberOfWays/1]).

numberOfWays(Points) ->
    % Sort points: by x-coordinate ascending, then y-coordinate ascending for ties.
    SortedPoints = lists:sort(fun([X1, Y1], [X2, Y2]) ->
                                  if X1 =/= X2 -> X1 < X2;
                                     true -> Y1 < Y2
                                  end
                              end, Points),

    % Initialize accumulator for the total count of valid pairs.
    Acc = 0,

    % Outer loop: Iterate through each point P1.
    % For each P1, we consider it as the starting point for rectangles.
    lists:foldl(fun(P1, CurrentTotalCount) ->
        [X1, Y1] = P1,

        % Initialize MinYEnv and MaxYEnv for the current P1.
        % These variables track the vertical envelope (min and max y-coordinates)
        % of all points encountered so far in the inner loop (P_k where k < j, including P1).
        % This envelope helps to determine if a new point P2 is "blocked" by previously seen points.
        MinYEnv = Y1,
        MaxYEnv = Y1,

        % Get the sublist of points that come after P1 in the sorted list.
        % This avoids re-sorting and ensures P2 is always to the right or above P1 (if X coords are same).
        P1s = lists:dropwhile(fun(P) -> P =/= P1 end, SortedPoints),
        RestP1s = tl(P1s), % Points after P1

        % Inner loop: Iterate through each point P2 from the remaining points.
        % For each P2, we determine if the rectangle formed by P1 and P2 is empty.
        {NewTotalCount, _, _} = lists:foldl(fun(P2, {InnerCount, CurrentMinYEnv, CurrentMaxYEnv}) ->
            [X2, Y2] = P2,

            NewInnerCount = if X1 =:= X2 ->
                                % Case 1: P1 and P2 are on the same vertical line.
                                % The rectangle formed is a vertical line segment.
                                % No points can be strictly inside a line segment.
                                % So, this is always a valid pair.
                                InnerCount + 1;
                            true -> % Case 2: P2 is to the right of P1 (X1 < X2 due to sorting).
                                % We need to check if any point P_k (from P1 to P_j-1, excluding P1 and P2 themselves)
                                % is strictly inside the rectangle formed by P1 and P2.
                                % The CurrentMinYEnv and CurrentMaxYEnv represent the vertical range
                                % of all points encountered so far (from P1 up to P_j-1).
                                % If Y2 falls *outside* this envelope (i.e., Y2 < CurrentMinYEnv or Y2 > CurrentMaxYEnv),
                                % it means no point P_k (with X_k between X1 and X2) can be vertically between Y1 and Y2.
                                % This is because Y1 is part of the envelope, and if Y2 is outside, then the
                                % vertical range (min(Y1, Y2), max(Y1, Y2)) cannot contain any Y_k from the envelope.
                                if Y2 < CurrentMinYEnv or Y2 > CurrentMaxYEnv ->
                                    InnerCount + 1;
                                else
                                    % Y2 is within the envelope, meaning there's a point P_k (from P1 to P_j-1)
                                    % that is vertically between Y1 and Y2 (or on the boundary).
                                    % This P_k would block the rectangle.
                                    InnerCount
                                end
                            end,

            % Update the vertical envelope to include P2 for subsequent inner loop iterations.
            NewMinYEnv = min(CurrentMinYEnv, Y2),
            NewMaxYEnv = max(CurrentMaxYEnv, Y2),

            {NewInnerCount, NewMinYEnv, NewMaxYEnv}
        end, {CurrentTotalCount, MinYEnv, MaxYEnv}, RestP1s),

        NewTotalCount
    end, Acc, SortedPoints).