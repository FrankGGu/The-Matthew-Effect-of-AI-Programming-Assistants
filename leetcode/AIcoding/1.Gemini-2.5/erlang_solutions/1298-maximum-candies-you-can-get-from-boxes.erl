-module(solution).
-export([maxCandies/5]).

maxCandies(StatusList, CandiesList, KeysList, ContainedBoxesList, InitialBoxes) ->
    N = length(StatusList),

    % Convert input lists to arrays for O(1) access
    StatusArray = array:from_list(StatusList),
    CandiesArray = array:from_list(CandiesList),
    KeysArray = array:from_list(KeysList),
    ContainedBoxesArray = array:from_list(ContainedBoxesList),

    % Initialize state arrays
    % HasBoxArray[i] = true if we possess box i
    % OpenedArray[i] = true if box i has been opened
    HasBoxArray = array:new([{size, N}, {default, false}]),
    OpenedArray = array:new([{size, N}, {default, false}]),

    % Initialize a queue for boxes to process
    Q = queue:new(),

    % Initialize total candies
    TotalCandies = 0,

    % Process initial boxes: set HasBoxArray for them and add to queue if openable
    {InitialQ, InitialHasBoxArray} = lists:foldl(
        fun(BoxIdx, {AccQ, AccHasBoxArray}) ->
            NewHasBoxArray = array:set(BoxIdx, true, AccHasBoxArray),
            CurrentStatus = array:get(BoxIdx, StatusArray),
            case CurrentStatus of
                1 -> {queue:in(BoxIdx, AccQ), NewHasBoxArray};
                0 -> {AccQ, NewHasBoxArray}
            end
        end,
        {Q, HasBoxArray},
        InitialBoxes
    ),

    % Start BFS-like processing
    bfs(InitialQ, StatusArray, CandiesArray, KeysArray, ContainedBoxesArray, InitialHasBoxArray, OpenedArray, TotalCandies).

bfs(Q, StatusArray, CandiesArray, KeysArray, ContainedBoxesArray, HasBoxArray, OpenedArray, TotalCandies) ->
    case queue:out(Q) of
        {{value, BoxIdx}, RestQ} ->
            % If already opened, skip
            case array:get(BoxIdx, OpenedArray) of
                true ->
                    bfs(RestQ, StatusArray, CandiesArray, KeysArray, ContainedBoxesArray, HasBoxArray, OpenedArray, TotalCandies);
                false ->
                    % Mark as opened
                    NewOpenedArray = array:set(BoxIdx, true, OpenedArray),

                    % Add candies
                    CandiesInBox = array:get(BoxIdx, CandiesArray),
                    NewTotalCandies = TotalCandies + CandiesInBox,

                    % Process keys found in this box
                    KeysInBox = array:get(BoxIdx, KeysArray),
                    {Q1, StatusArray1} = lists:foldl(
                        fun(KeyTargetBox, {AccQ, AccStatusArray}) ->
                            CurrentStatus = array:get(KeyTargetBox, AccStatusArray),
                            case CurrentStatus of
                                0 -> % Box was closed, now open
                                    NewStatusArray = array:set(KeyTargetBox, 1, AccStatusArray),
                                    HasTargetBox = array:get(KeyTargetBox, HasBoxArray),
                                    IsTargetOpened = array:get(KeyTargetBox, NewOpenedArray),
                                    case {HasTargetBox, IsTargetOpened} of
                                        {true, false} -> {queue:in(KeyTargetBox, AccQ), NewStatusArray};
                                        _ -> {AccQ, NewStatusArray}
                                    end;
                                1 -> % Box was already open
                                    {AccQ, AccStatusArray}
                            end
                        end,
                        {RestQ, StatusArray},
                        KeysInBox
                    ),

                    % Process contained boxes found in this box
                    Contained = array:get(BoxIdx, ContainedBoxesArray),
                    {FinalQ, FinalHasBoxArray} = lists:foldl(
                        fun(ContainedBox, {AccQ, AccHasBoxArray}) ->
                            HasContainedBox = array:get(ContainedBox, AccHasBoxArray),
                            case HasContainedBox of
                                false -> % Didn't have it before, now we do
                                    NewHasBoxArray = array:set(ContainedBox, true, AccHasBoxArray),
                                    CurrentStatus = array:get(ContainedBox, StatusArray1), % Use updated status
                                    IsContainedOpened = array:get(ContainedBox, NewOpenedArray),
                                    case {CurrentStatus, IsContainedOpened} of
                                        {1, false} -> {queue:in(ContainedBox, AccQ), NewHasBoxArray};
                                        _ -> {AccQ, NewHasBoxArray}
                                    end;
                                true -> % Already had it
                                    {AccQ, AccHasBoxArray}
                            end
                        end,
                        {Q1, HasBoxArray},
                        Contained
                    ),

                    bfs(FinalQ, StatusArray1, CandiesArray, KeysArray, ContainedBoxesArray, FinalHasBoxArray, NewOpenedArray, NewTotalCandies)
            end;
        {empty, _} ->
            TotalCandies
    end.