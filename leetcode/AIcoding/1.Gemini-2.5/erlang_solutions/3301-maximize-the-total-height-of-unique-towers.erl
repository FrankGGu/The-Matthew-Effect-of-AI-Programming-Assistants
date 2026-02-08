-module(solution).
-export([maximum_total_height_of_unique_towers/1]).

maximum_total_height_of_unique_towers(MaxHeights) ->
    N = length(MaxHeights),
    MaxTotalHeight = 0,

    % Iterate through each possible building 'I' as the peak of a mountain shape.
    lists:foldl(fun(I, AccMaxTotalHeight) ->
        % Get the maximum allowed height for the current peak building I.
        PeakHeight = lists:nth(I + 1, MaxHeights), % lists:nth is 1-indexed

        % Initialize the total height for this specific peak.
        CurrentTotalHeightForPeak = PeakHeight,

        % Calculate heights for buildings to the left of the peak (from I-1 down to 0).
        % Heights must decrease by at most 1 for adjacent buildings, and respect maxHeights.
        LeftCurrentHeight = PeakHeight,
        {LeftSum, _} = lists:foldl(fun(J, {AccSum, AccPrevHeight}) ->
            % Calculate height H_J for building J:
            % It must be at most AccPrevHeight - 1 (from constraint |h[j]-h[j+1]| <= 1)
            % It must be at most lists:nth(J+1, MaxHeights) (from restriction)
            % It must be at least 0.
            H_J = max(0, min(AccPrevHeight - 1, lists:nth(J + 1, MaxHeights))),
            {AccSum + H_J, H_J}
        end, {0, LeftCurrentHeight}, lists:seq(I - 1, 0, -1)),

        % Calculate heights for buildings to the right of the peak (from I+1 up to N-1).
        % Heights must decrease by at most 1 for adjacent buildings, and respect maxHeights.
        RightCurrentHeight = PeakHeight,
        {RightSum, _} = lists:foldl(fun(J, {AccSum, AccPrevHeight}) ->
            % Calculate height H_J for building J:
            % It must be at most AccPrevHeight - 1 (from constraint |h[j]-h[j-1]| <= 1)
            % It must be at most lists:nth(J+1, MaxHeights) (from restriction)
            % It must be at least 0.
            H_J = max(0, min(AccPrevHeight - 1, lists:nth(J + 1, MaxHeights))),
            {AccSum + H_J, H_J}
        end, {0, RightCurrentHeight}, lists:seq(I + 1, N - 1)),

        % Sum up the height of the peak, and the sums from left and right.
        TotalHeightForThisPeak = CurrentTotalHeightForPeak + LeftSum + RightSum,

        % Update the overall maximum total height found so far.
        max(AccMaxTotalHeight, TotalHeightForThisPeak)
    end, MaxTotalHeight, lists:seq(0, N - 1)).