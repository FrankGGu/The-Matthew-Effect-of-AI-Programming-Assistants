-module(solution).
-export([dailyTemperatures/1]).

dailyTemperatures(Temperatures) ->
    Len = length(Temperatures),
    ResultArray = array:new([{fixed, true}, {size, Len}, {default, 0}]),
    dailyTemperatures_iter(0, Temperatures, [], ResultArray, Len).

dailyTemperatures_iter(_Index, [], _Stack, ResultArray, _Len) ->
    array:to_list(ResultArray);
dailyTemperatures_iter(Index, [CurrentTemp | Rest], Stack, ResultArray, Len) ->
    {UpdatedResultArray, RemainingStack} = 
        process_stack(CurrentTemp, Index, Stack, ResultArray),

    NewStack = [{CurrentTemp, Index} | RemainingStack],

    dailyTemperatures_iter(Index + 1, Rest, NewStack, UpdatedResultArray, Len).

process_stack(CurrentTemp, CurrentIndex, [{PrevTemp, PrevIndex} | RestStack], ResultArray) when CurrentTemp > PrevTemp ->
    Diff = CurrentIndex - PrevIndex,
    UpdatedResultArray = array:set(PrevIndex, Diff, ResultArray),
    process_stack(CurrentTemp, CurrentIndex, RestStack, UpdatedResultArray);
process_stack(_CurrentTemp, _CurrentIndex, Stack, ResultArray) ->
    {ResultArray, Stack}.