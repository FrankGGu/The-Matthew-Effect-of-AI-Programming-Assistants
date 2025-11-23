-module(solution).
-export([min_time_to_complete_all_tasks/1]).

min_time_to_complete_all_tasks(Tasks) ->
    SortedTasks = lists:sort(fun([S1, E1, _D1], [S2, E2, _D2]) when E1 =:= E2 ->
                                     S1 < S2;
                                ([_S1, E1, _D1], [_S2, E2, _D2]) ->
                                     E1 < E2
                             end, Tasks),

    MaxTime = lists:foldl(fun([_S, E, _D], Acc) -> max(E, Acc) end, 0, Tasks),

    IsOnArray = array:new(MaxTime + 1, {default, false}),

    {_FinalIsOnArray, TotalTime} = lists:foldl(
        fun([S, E, D], {CurrentIsOnArray, CurrentTotalTime}) ->
            ActiveDuration = count_active_in_range(S, E, CurrentIsOnArray),
            Needed = D - ActiveDuration,

            if
                Needed > 0 ->
                    activate_points(S, E, Needed, CurrentIsOnArray, CurrentTotalTime)
                else
                    {CurrentIsOnArray, CurrentTotalTime}
            end
        end,
        {IsOnArray, 0},
        SortedTasks
    ),
    TotalTime.

count_active_in_range(Start, End, IsOnArray) ->
    count_active_in_range(Start, End, IsOnArray, 0).

count_active_in_range(Current, End, IsOnArray, Acc) when Current =< End ->
    case array:get(Current, IsOnArray) of
        true -> count_active_in_range(Current + 1, End, IsOnArray, Acc + 1);
        false -> count_active_in_range(Current + 1, End, IsOnArray, Acc)
    end;
count_active_in_range(_Current, _End, _IsOnArray, Acc) ->
    Acc.

activate_points(S, E, Needed, IsOnArray, CurrentTotalTime) ->
    activate_points_recursive(E, S, Needed, IsOnArray, CurrentTotalTime).

activate_points_recursive(_CurrentTime, _Start, 0, IsOnArray, CurrentTotalTime) ->
    {IsOnArray, CurrentTotalTime};
activate_points_recursive(CurrentTime, Start, Needed, IsOnArray, CurrentTotalTime) when CurrentTime >= Start ->
    case array:get(CurrentTime, IsOnArray) of
        true ->
            activate_points_recursive(CurrentTime - 1, Start, Needed, IsOnArray, CurrentTotalTime);
        false ->
            NewIsOnArray = array:set(CurrentTime, true, IsOnArray),
            activate_points_recursive(CurrentTime - 1, Start, Needed - 1, NewIsOnArray, CurrentTotalTime + 1)
    end;
activate_points_recursive(_CurrentTime, _Start, _Needed, IsOnArray, CurrentTotalTime) ->
    {IsOnArray, CurrentTotalTime}.