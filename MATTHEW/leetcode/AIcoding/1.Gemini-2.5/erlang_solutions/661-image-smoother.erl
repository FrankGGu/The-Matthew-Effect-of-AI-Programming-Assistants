-module(solution).
-export([image_smoother/1]).

image_smoother(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Convert Grid (list of lists) to TupleGrid (tuple of tuples) for O(1) element access.
    % This significantly improves performance over repeated lists:nth/2 calls.
    TupleGrid = list_to_tuple([ list_to_tuple(Row) || Row <- Grid ]),

    % Generate the new smoothed grid using list comprehensions.
    % Iterate through each row (R) and each column (C) to calculate its smoothed value.
    [ [ calculate_smoothed_value(R, C, M, N, TupleGrid) || C <- lists:seq(0, N-1) ] || R <- lists:seq(0, M-1) ].

calculate_smoothed_value(R, C, M, N, TupleGrid) ->
    % Define all 9 relative coordinates for neighbors (including the cell itself).
    NeighborOffsets = [ {DR, DC} || DR <- [-1, 0, 1], DC <- [-1, 0, 1] ],

    % Use lists:foldl to iterate through all neighbor offsets and accumulate sum and count.
    {Sum, Count} = lists:foldl(
        fun({DR, DC}, {AccSum, AccCount}) ->
            NR = R + DR, % Calculate neighbor row index
            NC = C + DC, % Calculate neighbor column index

            % Check if the neighbor coordinates are within the grid bounds.
            if
                NR >= 0 andalso NR < M andalso NC >= 0 andalso NC < N ->
                    % If within bounds, retrieve the value using element/2 (O(1) access for tuples).
                    % Erlang's element/2 is 1-indexed, so we add 1 to 0-indexed R, C.
                    RowTuple = element(NR + 1, TupleGrid),
                    Val = element(NC + 1, RowTuple),
                    {AccSum + Val, AccCount + 1};
                true ->
                    % If out of bounds, do not include in sum or count.
                    {AccSum, AccCount}
            end
        end,
        {0, 0}, % Initial accumulator for sum and count.
        NeighborOffsets
    ),

    % Calculate the smoothed value using integer division (which performs floor division).
    % Count will always be at least 1 because the cell itself (DR=0, DC=0) is always valid.
    Sum div Count.