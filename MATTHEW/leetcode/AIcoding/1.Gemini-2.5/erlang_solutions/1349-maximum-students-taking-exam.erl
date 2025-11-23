-module(solution).
-export([maxStudents/1]).

maxStudents(Board) ->
    M = length(Board),
    N = length(hd(Board)),

    BrokenMasks = [calculate_broken_mask(Row, N) || Row <- Board],

    MaxMask = (1 bsl N) - 1,

    % Initialize DP for the first row (row 0)
    Row0BrokenMask = lists:nth(1, BrokenMasks), % BrokenMasks is 1-indexed for lists:nth
    InitialDPMap = maps:new(),
    InitialDPMapFilled = lists:foldl(fun(Mask, AccMap) ->
                                         if is_valid_row_mask(Mask, Row0BrokenMask) ->
                                             maps:put(Mask, erlang:popcount(Mask), AccMap);
                                         else
                                             AccMap
                                         end
                                     end, InitialDPMap, lists:seq(0, MaxMask)),

    % Iterate through rows from 1 to M-1
    % CurrentRowIdx is 0-indexed (1, 2, ..., M-1)
    % PrevRowMap is the DP map for the (CurrentRowIdx - 1)
    FinalDPMap = lists:foldl(fun(CurrentRowIdx, PrevRowMap) ->
                                 CurrentRowBrokenMask = lists:nth(CurrentRowIdx + 1, BrokenMasks),
                                 CurrentRowMap = maps:new(),
                                 lists:foldl(fun(CurrentMask, AccCurrentRowMap) ->
                                                 if is_valid_row_mask(CurrentMask, CurrentRowBrokenMask) ->
                                                     StudentsInCurrentMask = erlang:popcount(CurrentMask),

                                                     MaxStudentsFromPrev = lists:foldl(fun(PrevMask, CurrentMax) ->
                                                                                           case maps:find(PrevMask, PrevRowMap) of
                                                                                               {ok, StudentsFromPrevRows} ->
                                                                                                   if is_valid_prev_current_mask_pair(PrevMask, CurrentMask) ->
                                                                                                       max(CurrentMax, StudentsFromPrevRows);
                                                                                                   else
                                                                                                       CurrentMax
                                                                                                   end;
                                                                                               error ->
                                                                                                   CurrentMax
                                                                                           end
                                                                                       end, -1, lists:seq(0, MaxMask)),

                                                     if MaxStudentsFromPrev /= -1 ->
                                                         maps:put(CurrentMask, StudentsInCurrentMask + MaxStudentsFromPrev, AccCurrentRowMap);
                                                     else
                                                         AccCurrentRowMap
                                                     end;
                                                 else
                                                     AccCurrentRowMap
                                                 end
                                             end, CurrentRowMap, lists:seq(0, MaxMask))
                             end, InitialDPMapFilled, lists:seq(1, M-1)),

    % The final result is the maximum value in the DP map for the last row
    Result = lists:foldl(fun(Mask, CurrentMax) ->
                             max(CurrentMax, maps:get(Mask, FinalDPMap))
                         end, 0, maps:keys(FinalDPMap)),
    Result.

calculate_broken_mask(Row, N) ->
    lists:foldl(fun({Char, ColIdx}, AccMask) ->
                    if Char == $. ->
                        AccMask bor (1 bsl ColIdx);
                    else
                        AccMask
                    end
                end, 0, lists:zip(Row, lists:seq(0, N-1))).

is_valid_row_mask(Mask, BrokenMask) ->
    (Mask band BrokenMask) == 0 % No student on a broken seat
    andalso ((Mask band (Mask bsl 1)) == 0). % No horizontal adjacency

is_valid_prev_current_mask_pair(PrevMask, CurrentMask) ->
    (CurrentMask band (PrevMask bsl 1)) == 0 % No diagonal top-left
    andalso ((CurrentMask band (PrevMask bsr 1)) == 0). % No diagonal top-right