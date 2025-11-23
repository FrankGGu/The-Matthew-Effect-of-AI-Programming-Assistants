-module(solution).
-export([min_garbage_time/2]).

min_garbage_time(Garbage, Travel) ->
    TravelPrefixSums = lists:foldl(fun(T, Acc) ->
        [lists:last(Acc) + T | Acc]
    end, [0], Travel) |> lists:reverse(),

    % State tuple: {PickupM, PickupP, PickupG, LastMIdx, LastPIdx, LastGIdx}
    % LastXIdx is the 0-based index of the last house containing garbage type X.
    % Initial LastXIdx is 0, meaning house 0. If no garbage of a type is found,
    % its last index remains 0, and travel time to house 0 is 0.
    InitialState = {0, 0, 0, 0, 0, 0},

    {PickupM, PickupP, PickupG, LastMIdx, LastPIdx, LastGIdx} =
        process_garbage_recursive(Garbage, 0, InitialState),

    TravelM = lists:nth(LastMIdx + 1, TravelPrefixSums),
    TravelP = lists:nth(LastPIdx + 1, TravelPrefixSums),
    TravelG = lists:nth(LastGIdx + 1, TravelPrefixSums),

    PickupM + TravelM + PickupP + TravelP + PickupG + TravelG.

process_garbage_recursive([], _CurrentIdx, Acc) ->
    Acc;
process_garbage_recursive([HouseGarbage | Rest], CurrentIdx, {PM, PP, PG, LM, LP, LG}) ->
    NewState = lists:foldl(fun(Char, {AccPM, AccPP, AccPG, AccLM, AccLP, AccLG}) ->
        case Char of
            $M -> {AccPM + 1, AccPP, AccPG, CurrentIdx, AccLP, AccLG};
            $P -> {AccPM, AccPP + 1, AccPG, AccLM, CurrentIdx, AccLG};
            $G -> {AccPM, AccPP, AccPG + 1, AccLM, AccLP, CurrentIdx};
            _ -> {AccPM, AccPP, AccPG, AccLM, AccLP, AccLG}
        end
    end, {PM, PP, PG, LM, LP, LG}, HouseGarbage),
    process_garbage_recursive(Rest, CurrentIdx + 1, NewState).