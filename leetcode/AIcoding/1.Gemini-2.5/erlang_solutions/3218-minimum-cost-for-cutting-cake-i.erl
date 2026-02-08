-module(solution).
-export([min_cost_cutting_cake/4]).

min_cost_cutting_cake(_M, _N, HorizontalCut, VerticalCut) ->
    % Sort cuts in descending order to prioritize more expensive cuts first.
    SortedHorizontal = lists:sort(fun(A, B) -> A >= B end, HorizontalCut),
    SortedVertical = lists:sort(fun(A, B) -> A >= B end, VerticalCut),

    % Initialize number of horizontal and vertical pieces to 1.
    % Initialize accumulated cost to 0.
    solve(SortedHorizontal, SortedVertical, 1, 1, 0).

solve([], [], _HPieces, _VPieces, AccCost) ->
    % Base case: No more cuts left, return accumulated cost.
    AccCost;
solve([H | Hs], [], HPieces, VPieces, AccCost) ->
    % Only horizontal cuts remain.
    % Add cost of current horizontal cut multiplied by the number of vertical pieces.
    % Increment the number of horizontal pieces.
    solve(Hs, [], HPieces + 1, VPieces, AccCost + H * VPieces);
solve([], [V | Vs], HPieces, VPieces, AccCost) ->
    % Only vertical cuts remain.
    % Add cost of current vertical cut multiplied by the number of horizontal pieces.
    % Increment the number of vertical pieces.
    solve([], Vs, HPieces, VPieces + 1, AccCost + V * HPieces);
solve([H | Hs], [V | Vs], HPieces, VPieces, AccCost) ->
    % Both horizontal and vertical cuts are available.
    % Greedily choose the cut with the higher cost.
    if
        H >= V ->
            % Choose horizontal cut.
            % Add cost of H multiplied by current number of vertical pieces.
            % Increment horizontal pieces count.
            solve(Hs, [V | Vs], HPieces + 1, VPieces, AccCost + H * VPieces);
        true ->
            % Choose vertical cut.
            % Add cost of V multiplied by current number of horizontal pieces.
            % Increment vertical pieces count.
            solve([H | Hs], Vs, HPieces, VPieces + 1, AccCost + V * HPieces)
    end.