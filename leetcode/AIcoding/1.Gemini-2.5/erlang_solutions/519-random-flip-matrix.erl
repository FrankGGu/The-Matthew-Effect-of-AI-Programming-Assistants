-module(solution).

-export([init/2, flip/1, reset/1]).

init(M, N) ->
    Total = M * N,
    random:seed(erlang:monotonic_time(), erlang:unique_integer([single])),
    {M, N, Total, #{}}.

flip({M, N, CurrentSize, Map}) ->
    R_idx = random:uniform(CurrentSize) - 1,

    ActualIdxToReturn = maps:get(R_idx, Map, R_idx),

    LastAvailableIdx = CurrentSize - 1,
    ActualIdxOfLast = maps:get(LastAvailableIdx, Map, LastAvailableIdx),

    NewMap_temp = maps:put(R_idx, ActualIdxOfLast, Map),
    NewMap = 
        case maps:is_key(LastAvailableIdx, Map) of
            true -> maps:remove(LastAvailableIdx, NewMap_temp);
            false -> NewMap_temp
        end,

    NewCurrentSize = CurrentSize - 1,

    Row = ActualIdxToReturn div N,
    Col = ActualIdxToReturn rem N,

    {[Row, Col], {M, N, NewCurrentSize, NewMap}}.

reset({M, N, _CurrentSize, _Map}) ->
    Total = M * N,
    {M, N, Total, #{}}.