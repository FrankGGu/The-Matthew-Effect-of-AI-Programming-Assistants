-module(solution).
-export([max_visible_points/3]).

max_visible_points(Points, Location, Angle) ->
    {AtLocationCount, OtherPoints} = lists:foldl(
        fun({Px, Py}, {Count, Others}) ->
            {Lx, Ly} = Location,
            if Px == Lx andalso Py == Ly ->
                {Count + 1, Others};
            true ->
                {Count, [{Px, Py} | Others]}
            end
        end,
        {0, []},
        Points
    ),

    Angles = lists:map(
        fun({Px, Py}) ->
            {Lx, Ly} = Location,
            Dx = Px - Lx,
            Dy = Py - Ly,
            Rad = math:atan2(Dy, Dx),
            Deg = math:rad_to_deg(Rad),
            erlang:rem(Deg + 360, 360)
        end,
        OtherPoints
    ),

    SortedAngles = lists:sort(Angles),

    ExtendedAngles = SortedAngles ++ lists:map(fun(A) -> A + 360 end, SortedAngles),

    MaxVisibleInWindow = sliding_window_array(ExtendedAngles, Angle),

    MaxVisibleInWindow + AtLocationCount.

sliding_window_array(Angles, MaxAngle) ->
    Len = length(Angles),
    if Len == 0 ->
        0;
    true ->
        Array = array:from_list(Angles),
        sliding_window_loop(Array, MaxAngle, 0, 0, 0, Len)
    end.

sliding_window_loop(Array, MaxAngle, LeftIdx, RightIdx, MaxCount, Len) when RightIdx < Len ->
    CurrentRightAngle = array:get(RightIdx, Array),

    NewLeftIdx = adjust_left_pointer(Array, LeftIdx, RightIdx, MaxAngle, CurrentRightAngle),

    CurrentCount = RightIdx - NewLeftIdx + 1,

    NewMaxCount = erlang:max(MaxCount, CurrentCount),

    sliding_window_loop(Array, MaxAngle, NewLeftIdx, RightIdx + 1, NewMaxCount, Len);
sliding_window_loop(_Array, _MaxAngle, _LeftIdx, _RightIdx, MaxCount, _Len) ->
    MaxCount.

adjust_left_pointer(Array, LeftIdx, RightIdx, MaxAngle, CurrentRightAngle) ->
    adjust_left_pointer_rec(Array, LeftIdx, RightIdx, MaxAngle, CurrentRightAngle).

adjust_left_pointer_rec(Array, LeftIdx, RightIdx, MaxAngle, CurrentRightAngle) when LeftIdx <= RightIdx ->
    LeftAngle = array:get(LeftIdx, Array),
    if CurrentRightAngle - LeftAngle > MaxAngle ->
        adjust_left_pointer_rec(Array, LeftIdx + 1, RightIdx, MaxAngle, CurrentRightAngle);
    true ->
        LeftIdx
    end;
adjust_left_pointer_rec(_Array, LeftIdx, _RightIdx, _MaxAngle, _CurrentRightAngle) ->
    LeftIdx.