-module(solution).
-export([max_force/2]).

max_force(Position, M) ->
    SortedPositions = lists:sort(Position),
    Low = 1,
    High = lists:last(SortedPositions) - hd(SortedPositions),
    binary_search(Low, High, 0, SortedPositions, M).

binary_search(Low, High, Ans, _Positions, _M) when Low > High ->
    Ans;
binary_search(Low, High, Ans, Positions, M) ->
    Mid = Low + (High - Low) div 2,
    case can_place(Mid, M, Positions) of
        true ->
            binary_search(Mid + 1, High, Mid, Positions, M);
        false ->
            binary_search(Low, Mid - 1, Ans, Positions, M)
    end.

can_place(MinDist, M, Positions) ->
    % Place the first ball at the first position, then try to place M-1 more balls
    can_place_impl(MinDist, M - 1, hd(Positions), tl(Positions)).

can_place_impl(_MinDist, 0, _LastPlacedPos, _RemainingPositions) ->
    true; % All required balls have been placed
can_place_impl(_MinDist, _RemainingBallsToPlace, _LastPlacedPos, []) ->
    false; % Not enough positions left to place remaining balls
can_place_impl(MinDist, RemainingBallsToPlace, LastPlacedPos, [H|T]) ->
    case H - LastPlacedPos >= MinDist of
        true ->
            % Place a ball at H, decrement remaining balls, update last placed position
            can_place_impl(MinDist, RemainingBallsToPlace - 1, H, T);
        false ->
            % Cannot place a ball at H yet, try the next position
            can_place_impl(MinDist, RemainingBallsToPlace, LastPlacedPos, T)
    end.