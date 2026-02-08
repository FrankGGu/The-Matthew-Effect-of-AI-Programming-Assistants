-module(solution).
-export([find_min_arrow_shots/1]).

%% Function to find the minimum number of arrows to burst all balloons
-spec find_min_arrow_shots([[integer()]]) -> integer().
find_min_arrow_shots(Points) ->
    %% Sort the points based on the ending coordinate.
    SortedPoints = lists:sort(fun({_, End1}, {_, End2}) -> End1 < End2 end, Points),
    %% Initialize the first arrow to shoot.
    find_min_arrow_shots(SortedPoints, -infinity, 0).

%% Helper function to process the sorted points.
-spec find_min_arrow_shots([[integer()]], integer(), integer()) -> integer().
find_min_arrow_shots([], _, Arrows) -> Arrows;
find_min_arrow_shots([[Start, End] | Rest], LastArrowPos, Arrows) when Start > LastArrowPos ->
    %% If the start of the current balloon is greater than the last arrow position,
    %% shoot a new arrow at the end of the current balloon.
    find_min_arrow_shots(Rest, End, Arrows + 1);
find_min_arrow_shots([_ | Rest], LastArrowPos, Arrows) ->
    %% If the current balloon is covered by the last arrow, continue without shooting.
    find_min_arrow_shots(Rest, LastArrowPos, Arrows).
