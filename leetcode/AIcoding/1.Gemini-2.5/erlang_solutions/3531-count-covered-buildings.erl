-module(solution).
-export([countCoveredBuildings/1]).

countCoveredBuildings(Buildings) ->
    % Sort buildings primarily by x-coordinate in ascending order.
    % If x-coordinates are equal, sort by y-coordinate in descending order.
    % This sorting strategy ensures that when we iterate, if a building [X, Y]
    % has its Y-coordinate less than or equal to the maximum Y-coordinate encountered
    % so far (from buildings with X-coordinates less than or equal to X),
    % then it is covered.
    SortedBuildings = lists:sort(fun([X1, Y1], [X2, Y2]) ->
                                        if X1 < X2 -> true;
                                           X1 > X2 -> false;
                                           true -> Y1 >= Y2 % X1 == X2, sort Y descending
                                        end
                                end, Buildings),

    % Use lists:foldl to iterate through the sorted buildings.
    % The accumulator state is {CoveredCount, MaxYSeenSoFar}.
    % CoveredCount: The number of buildings identified as covered.
    % MaxYSeenSoFar: The maximum Y-coordinate encountered among buildings
    %                that were NOT themselves covered by a preceding building.
    % Initial state: {0, -1}. Assuming Y-coordinates are non-negative.
    {CoveredCount, _} = lists:foldl(fun([_X, Y], {AccCount, MaxY}) ->
                                            if Y =< MaxY ->
                                                % If the current building's Y-coordinate is less than or equal to
                                                % MaxYSeenSoFar, it means there exists a previous building (or a building
                                                % with the same X but larger Y due to sorting) that covers it.
                                                % The MaxYSeenSoFar should not be updated with the current Y,
                                                % as this building is covered and doesn't contribute to future covering.
                                                {AccCount + 1, MaxY};
                                            true ->
                                                % If the current building's Y-coordinate is greater than MaxYSeenSoFar,
                                                % it means this building is not covered by any previous building.
                                                % This building now becomes a candidate to cover subsequent buildings,
                                                % so we update MaxYSeenSoFar to its Y-coordinate.
                                                {AccCount, Y}
                                            end
                                    end, {0, -1}, SortedBuildings),
    CoveredCount.