-module(solution).
-export([videoStitching/2]).

videoStitching(Clips, T) ->
    % Sort clips by start time. If start times are equal, sort by end time.
    % This ensures we always consider clips from left to right.
    SortedClips = lists:sort(fun([S1,E1], [S2,E2]) ->
                                 if S1 < S2 -> true;
                                    S1 > S2 -> false;
                                    true -> E1 =< E2 % Prefer longer clips if starts are equal
                                 end
                             end, Clips),

    % Call the main greedy stitching function.
    % Args: All sorted clips, target time T, current covered end, clips count,
    %       index of the next clip to consider in SortedClips (0-based).
    greedy_stitch(SortedClips, T, 0, 0, 0).

greedy_stitch(AllClips, T, CurrentEnd, ClipsCount, CurrentClipIdx) ->
    % Base case: If we have covered the target time (or exceeded it),
    % we have found a valid solution. Return the count of clips used.
    if CurrentEnd >= T ->
        ClipsCount;
    true ->
        % In this step, we need to find the best clip to extend CurrentEnd.
        % The best clip is one that starts <= CurrentEnd and has the largest End time.
        % We also need to know the index of the first clip that starts > CurrentEnd
        % to efficiently continue the search in the next step (avoid re-scanning).

        MaxReachInThisStep = CurrentEnd, % Initialize max reach for this step with the current coverage.

        % Call helper to find the best next clip and the new starting index for the next search.
        % It returns {NewMaxReach, NextSearchIdx}.
        {NewMaxReach, NextSearchIdx} =
            find_best_next_clip(AllClips, CurrentClipIdx, CurrentEnd, MaxReachInThisStep),

        % If NewMaxReach is still the same as CurrentEnd, it means no clip could extend coverage.
        % This implies it's impossible to reach T.
        if NewMaxReach == CurrentEnd ->
            -1;
        true ->
            % Successfully extended coverage. Increment clips count and recurse.
            % NextSearchIdx points to the first clip that starts *after* the previous CurrentEnd.
            % This is the starting point for the next search.
            greedy_stitch(AllClips, T, NewMaxReach, ClipsCount + 1, NextSearchIdx)
        end
    end.

find_best_next_clip(AllClips, StartScanIdx, CurrentEnd, AccMaxReach) ->
    TotalLen = length(AllClips),
    % Helper loop for scanning.
    % Args: AllClips, CurrentScanIdx, TotalLen, CurrentEnd, AccumulatedMaxReach
    find_best_next_clip_loop(AllClips, StartScanIdx, TotalLen, CurrentEnd, AccMaxReach).

find_best_next_clip_loop(AllClips, CurrentScanIdx, TotalLen, CurrentEnd, AccMaxReach) ->
    if CurrentScanIdx >= TotalLen ->
        % Reached the end of the clips list.
        % No more clips to consider for extending CurrentEnd.
        % Return the accumulated max reach and the current index (which is TotalLen).
        {AccMaxReach, CurrentScanIdx};
    true ->
        % Get the current clip. lists:nth is 1-based, so add 1 to CurrentScanIdx.
        [Start, End] = lists:nth(CurrentScanIdx + 1, AllClips),

        if Start =< CurrentEnd ->
            % This clip is eligible: it starts within or at the current coverage boundary.
            % Update AccMaxReach if this clip extends further than any other eligible clip found so far.
            NewAccMaxReach = max(AccMaxReach, End),
            % Continue scanning to find more eligible clips or the first ineligible one.
            find_best_next_clip_loop(AllClips, CurrentScanIdx + 1, TotalLen, CurrentEnd, NewAccMaxReach);
        true ->
            % This clip starts beyond CurrentEnd. It means we cannot use this clip
            % (or any subsequent clips, because they are sorted by start time)
            % to extend the *current* CurrentEnd.
            % So, we stop scanning for eligible clips for *this* step.
            % Return the accumulated max reach and the CurrentScanIdx.
            % This CurrentScanIdx is the index of the first clip that starts > CurrentEnd,
            % which is exactly what we need for the next iteration of greedy_stitch.
            {AccMaxReach, CurrentScanIdx}
        end
    end.