-module(solution).
-export([avoidFlood/1]).

-include_lib("array/include/array.hrl"). % For array module
-include_lib("stdlib/include/gb_trees.hrl"). % For gb_trees module
-include_lib("stdlib/include/gb_sets.hrl"). % For gb_sets module

avoidFlood(Rains) ->
    N = length(Rains),
    RainsArray = array:from_list(Rains),

    % Pre-calculate NextRainDayList: NextRainDayList[i] stores the next day
    % that rains[i] (if > 0) will rain again. N+1 means no next rain.
    % We iterate from N-1 down to 0 to find the *next* occurrence.
    NextRainDayList = array:new(N, N + 1), % Initialize with N+1 (infinity)
    LastSeenDayMap = gb_trees:empty(),

    {FinalNextRainDayList, _} = 
        lists:foldl(fun(I, {AccNextRainDayList, AccLastSeenDayMap}) ->
                        LakeID = array:get(I, RainsArray),
                        if LakeID > 0 ->
                            NextDay = 
                                if gb_trees:is_defined(LakeID, AccLastSeenDayMap) ->
                                    gb_trees:get(LakeID, AccLastSeenDayMap);
                                else
                                    N + 1 % No next rain day found
                                end,
                            NewAccNextRainDayList = array:set(I, NextDay, AccNextRainDayList),
                            NewAccLastSeenDayMap = gb_trees:insert(LakeID, I, AccLastSeenDayMap),
                            {NewAccNextRainDayList, NewAccLastSeenDayMap};
                        true ->
                            {AccNextRainDayList, AccLastSeenDayMap}
                        end
                    end, {NextRainDayList, LastSeenDayMap}, lists:reverse(lists:seq(0, N-1))),

    % ans: The result array, initialized with 0s (will be updated to 1 for dry days if no lake is dried)
    AnsArray = array:new(N, 0),

    % LakeLastRainDay: gb_trees of LakeID -> LastRainDayIndex for currently flooded lakes
    LakeLastRainDay = gb_trees:empty(),

    % FloodedLakesToDry: gb_sets of {NextRainDayIndex, LakeID} for lakes that are currently flooded
    % and need to be dried. Ordered by NextRainDayIndex, then LakeID.
    FloodedLakesToDry = gb_sets:empty(),

    % Main loop
    try
        Result = lists:foldl(fun(DayIndex, {CurrentAnsArray, CurrentLakeLastRainDay, CurrentFloodedLakesToDry}) ->
            RainValue = array:get(DayIndex, RainsArray),
            if RainValue > 0 -> % It rains on RainValue lake
                NewAnsArray = array:set(DayIndex, -1, CurrentAnsArray),
                if gb_trees:is_defined(RainValue, CurrentLakeLastRainDay) ->
                    % Flood occurs, this lake is already flooded
                    throw(flood_detected);
                else
                    % This lake becomes flooded
                    NewLakeLastRainDay = gb_trees:insert(RainValue, DayIndex, CurrentLakeLastRainDay),
                    NextRainDay = array:get(DayIndex, FinalNextRainDayList),
                    NewFloodedLakesToDry = gb_sets:add({NextRainDay, RainValue}, CurrentFloodedLakesToDry),
                    {NewAnsArray, NewLakeLastRainDay, NewFloodedLakesToDry}
                end;
            true -> % RainValue == 0, it's a dry day
                if gb_sets:is_empty(CurrentFloodedLakesToDry) ->
                    % No lakes are currently flooded, no need to dry any specific lake
                    NewAnsArray = array:set(DayIndex, 1, CurrentAnsArray), % Problem says 1 is fine
                    {NewAnsArray, CurrentLakeLastRainDay, CurrentFloodedLakesToDry};
                else
                    % We must dry a lake. Pick the one that will rain earliest.
                    {NextRainDay, LakeToDry} = gb_sets:smallest(CurrentFloodedLakesToDry),
                    NewFloodedLakesToDry = gb_sets:delete({NextRainDay, LakeToDry}, CurrentFloodedLakesToDry),
                    NewLakeLastRainDay = gb_trees:delete(LakeToDry, CurrentLakeLastRainDay),
                    NewAnsArray = array:set(DayIndex, LakeToDry, CurrentAnsArray),
                    {NewAnsArray, NewLakeLastRainDay, NewFloodedLakesToDry}
                end
            end
        end, {AnsArray, LakeLastRainDay, FloodedLakesToDry}, lists:seq(0, N-1)),
        array:to_list(element(1, Result))
    catch
        throw:flood_detected ->
            []
    end.