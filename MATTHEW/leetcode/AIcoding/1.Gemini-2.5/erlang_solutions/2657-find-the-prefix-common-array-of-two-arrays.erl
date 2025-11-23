-module(solution).
-export([find_prefix_common_array/2]).

find_prefix_common_array(PermA, PermB) ->
    N = length(PermA),
    InitialSeenA = array:new({size, N + 1, default, false}),
    InitialSeenB = array:new({size, N + 1, default, false}),
    lists:reverse(
        find_prefix_common_array_recursive(PermA, PermB, InitialSeenA, InitialSeenB, 0, [])
    ).

find_prefix_common_array_recursive([], [], _SeenA, _SeenB, _CommonCount, Acc) ->
    Acc;
find_prefix_common_array_recursive([ValA | RestA], [ValB | RestB], SeenA, SeenB, CommonCount, Acc) ->
    CurrentCommonCount = CommonCount,

    NewCommonCount1 = if array:get(ValA, SeenA) == false andalso array:get(ValA, SeenB) == true ->
                          CurrentCommonCount + 1;
                      true ->
                          CurrentCommonCount
                      end,
    NewSeenA = array:set(ValA, true, SeenA),

    NewCommonCount2 = if array:get(ValB, SeenB) == false andalso array:get(ValB, NewSeenA) == true ->
                          NewCommonCount1 + 1;
                      true ->
                          NewCommonCount1
                      end,
    NewSeenB = array:set(ValB, true, SeenB),

    find_prefix_common_array_recursive(RestA, RestB, NewSeenA, NewSeenB, NewCommonCount2, [NewCommonCount2 | Acc]).