-module(solution).
-export([movesToStamp/2]).

movesToStamp(Stamp, Target) ->
    N = length(Target),
    M = length(Stamp),

    StampInts = Stamp, % Erlang strings are already lists of integers (ASCII values)
    TargetInts = Target,

    % State variables using Erlang's array module for efficient updates
    % TargetCharsArr: current state of the target string, initially TargetInts
    % ProcessedWindowsArr: boolean array, true if window 'i' has been added to queue
    % NumNonQMatchedArr: count of chars in window 'i' that match stamp and are not '?'
    % NumNonQUnmatchedArr: count of chars in window 'i' that don't match stamp and are not '?'

    TargetCharsArr = array:from_list(TargetInts),
    ProcessedWindowsArr = array:new(N - M + 1, {default, false}),
    NumNonQMatchedArr = array:new(N - M + 1, {default, 0}),
    NumNonQUnmatchedArr = array:new(N - M + 1, {default, 0}),

    Q = queue:new(),

    % Initial scan to populate the queue and initial counts
    {InitialQ, FinalNumNonQMatchedArr, FinalNumNonQUnmatchedArr, FinalProcessedWindowsArr} =
        scan_initial_windows_loop(0, N - M, N, M, StampInts, TargetCharsArr,
                                  NumNonQMatchedArr, NumNonQUnmatchedArr,
                                  ProcessedWindowsArr, Q),

    % BFS loop
    {FinalAns, FinalTotalQCount, _, _, _} = bfs_loop(N, M, StampInts, TargetCharsArr,
                                                     FinalNumNonQMatchedArr, FinalNumNonQUnmatchedArr,
                                                     FinalProcessedWindowsArr, InitialQ, [], 0),

    % Check if all characters are '?'
    if FinalTotalQCount == N ->
        lists:reverse(FinalAns);
    true ->
        []
    end.

is_q(Char) ->
    Char == $?.

scan_initial_windows_loop(I, MaxI, N, M, StampInts, TargetCharsArr,
                          NumNonQMatchedArr, NumNonQUnmatchedArr,
                          ProcessedWindowsArr, Q) when I =< MaxI ->
    {CurrentNumNonQMatched, CurrentNumNonQUnmatched} =
        scan_window_chars(0, M - 1, I, StampInts, TargetCharsArr, 0, 0),

    NewNumNonQMatchedArr = array:set(I, CurrentNumNonQMatched, NumNonQMatchedArr),
    NewNumNonQUnmatchedArr = array:set(I, CurrentNumNonQUnmatched, NumNonQUnmatchedArr),

    {NewQ, NewProcessedWindowsArr} =
        if CurrentNumNonQUnmatched == 0 andalso CurrentNumNonQMatched > 0 ->
               {queue:in(I, Q), array:set(I, true, ProcessedWindowsArr)};
           true ->
               {Q, ProcessedWindowsArr}
           end,
    scan_initial_windows_loop(I + 1, MaxI, N, M, StampInts, TargetCharsArr,
                              NewNumNonQMatchedArr, NewNumNonQUnmatchedArr,
                              NewProcessedWindowsArr, NewQ);
scan_initial_windows_loop(_I, _MaxI, _N, _M, _StampInts, _TargetCharsArr,
                          NumNonQMatchedArr, NumNonQUnmatchedArr,
                          ProcessedWindowsArr, Q) ->
    {Q, NumNonQMatchedArr, NumNonQUnmatchedArr, ProcessedWindowsArr}.

scan_window_chars(J, MaxJ, WindowStartIdx, StampInts, TargetCharsArr,
                  CurrentNumNonQMatched, CurrentNumNonQUnmatched) when J =< MaxJ ->
    CharInTarget = array:get(WindowStartIdx + J, TargetCharsArr),
    CharInStamp = lists:nth(J + 1, StampInts), % lists:nth is 1-indexed

    if CharInTarget == CharInStamp ->
        scan_window_chars(J + 1, MaxJ, WindowStartIdx, StampInts, TargetCharsArr,
                          CurrentNumNonQMatched + 1, CurrentNumNonQUnmatched);
    not is_q(CharInTarget) -> % Mismatch and not '?'
        scan_window_chars(J + 1, MaxJ, WindowStartIdx, StampInts, TargetCharsArr,
                          CurrentNumNonQMatched, CurrentNumNonQUnmatched + 1);
    true -> % CharInTarget is '?'
        scan_window_chars(J + 1, MaxJ, WindowStartIdx, StampInts, TargetCharsArr,
                          CurrentNumNonQMatched, CurrentNumNonQUnmatched)
    end;
scan_window_chars(_J, _MaxJ, _WindowStartIdx, _StampInts, _TargetCharsArr,
                  CurrentNumNonQMatched, CurrentNumNonQUnmatched) ->
    {CurrentNumNonQMatched, CurrentNumNonQUnmatched}.

bfs_loop(N, M, StampInts, TargetCharsArr,
         NumNonQMatchedArr, NumNonQUnmatchedArr,
         ProcessedWindowsArr, Q, Ans, TotalQCount) ->
    case queue:out(Q) of
        {{value, CurrIdx}, NewQ} ->
            NewAns = [CurrIdx | Ans],
            {UpdatedTargetCharsArr, UpdatedTotalQCount,
             UpdatedNumNonQMatchedArr, UpdatedNumNonQUnmatchedArr,
             UpdatedProcessedWindowsArr, FinalQ} =
                process_current_window(0, M - 1, CurrIdx, N, M, StampInts, TargetCharsArr,
                                       NumNonQMatchedArr, NumNonQUnmatchedArr,
                                       ProcessedWindowsArr, NewQ, TotalQCount),
            bfs_loop(N, M, StampInts, UpdatedTargetCharsArr,
                     UpdatedNumNonQMatchedArr, UpdatedNumNonQUnmatchedArr,
                     UpdatedProcessedWindowsArr, FinalQ, NewAns, UpdatedTotalQCount);
        {empty, _} ->
            {Ans, TotalQCount, NumNonQMatchedArr, NumNonQUnmatchedArr, ProcessedWindowsArr}
    end.

process_current_window(J, MaxJ, CurrIdx, N, M, StampInts, TargetCharsArr,
                       NumNonQMatchedArr, NumNonQUnmatchedArr,
                       ProcessedWindowsArr, Q, TotalQCount) when J =< MaxJ ->
    CharIdxInTarget = CurrIdx + J,
    CharToChange = array:get(CharIdxInTarget, TargetCharsArr),

    if not is_q(CharToChange) ->
        NewTargetCharsArr = array:set(CharIdxInTarget, $?, TargetCharsArr),
        NewTotalQCount = TotalQCount + 1,

        % Update all overlapping windows that might now become stampable
        {UpdatedNumNonQMatchedArr, UpdatedNumNonQUnmatchedArr, UpdatedProcessedWindowsArr, NewQForOverlapping} =
            update_overlapping_windows(max(0, CharIdxInTarget - M + 1), min(N - M, CharIdxInTarget),
                                       CharIdxInTarget, CharToChange, StampInts,
                                       NumNonQMatchedArr, NumNonQUnmatchedArr,
                                       ProcessedWindowsArr, Q, M),
        process_current_window(J + 1, MaxJ, CurrIdx, N, M, StampInts, NewTargetCharsArr,
                               UpdatedNumNonQMatchedArr, UpdatedNumNonQUnmatchedArr,
                               UpdatedProcessedWindowsArr, NewQForOverlapping, NewTotalQCount);
    true -> % CharToChange is already '?'
        process_current_window(J + 1, MaxJ, CurrIdx, N, M, StampInts, TargetCharsArr,
                               NumNonQMatchedArr, NumNonQUnmatchedArr,
                               ProcessedWindowsArr, Q, TotalQCount)
    end;
process_current_window(_J, _MaxJ, _CurrIdx, _N, _M, _StampInts, TargetCharsArr,
                       NumNonQMatchedArr, NumNonQUnmatchedArr,
                       ProcessedWindowsArr, Q, TotalQCount) ->
    {TargetCharsArr, TotalQCount, NumNonQMatchedArr, NumNonQUnmatchedArr, ProcessedWindowsArr, Q}.

update_overlapping_windows(K, MaxK, CharIdxInTarget, CharToChange, StampInts,
                           NumNonQMatchedArr, NumNonQUnmatchedArr,
                           ProcessedWindowsArr, Q, M) when K =< MaxK ->
    if not array:get(K, ProcessedWindowsArr) -> % Only update windows not yet processed
        IdxInWindowK = CharIdxInTarget - K,
        CharInStampForWindowK = lists:nth(IdxInWindowK + 1, StampInts),

        NewNumNonQMatchedArr =
            if CharToChange == CharInStampForWindowK ->
                array:set(K, array:get(K, NumNonQMatchedArr) - 1, NumNonQMatchedArr);
            true ->
                NumNonQMatchedArr
            end,
        NewNumNonQUnmatchedArr =
            if CharToChange /= CharInStampForWindowK -> % If it was a mismatch
                array:set(K, array:get(K, NumNonQUnmatchedArr) - 1, NumNonQUnmatchedArr);
            true ->
                NumNonQUnmatchedArr
            end,

        % Check if window K is now stampable
        CurrentNumNonQMatched = array:get(K, NewNumNonQMatchedArr),
        CurrentNumNonQUnmatched = array:get(K, NewNumNonQUnmatchedArr),

        {FinalQ, FinalProcessedWindowsArr} =
            if CurrentNumNonQUnmatched == 0 andalso CurrentNumNonQMatched > 0 ->
                {queue:in(K, Q), array:set(K, true, ProcessedWindowsArr)};
            true ->
                {Q, ProcessedWindowsArr}
            end,
        update_overlapping_windows(K + 1, MaxK, CharIdxInTarget, CharToChange, StampInts,
                                   NewNumNonQMatchedArr, NewNumNonQUnmatchedArr,
                                   FinalProcessedWindowsArr, FinalQ, M);
    true -> % Window K already processed
        update_overlapping_windows(K + 1, MaxK, CharIdxInTarget, CharToChange, StampInts,
                                   NumNonQMatchedArr, NumNonQUnmatchedArr,
                                   ProcessedWindowsArr, Q, M)
    end;
update_overlapping_windows(_K, _MaxK, _CharIdxInTarget, _CharToChange, _StampInts,
                           NumNonQMatchedArr, NumNonQUnmatchedArr,
                           ProcessedWindowsArr, Q, _M) ->
    {NumNonQMatchedArr, NumNonQUnmatchedArr, ProcessedWindowsArr, Q}.