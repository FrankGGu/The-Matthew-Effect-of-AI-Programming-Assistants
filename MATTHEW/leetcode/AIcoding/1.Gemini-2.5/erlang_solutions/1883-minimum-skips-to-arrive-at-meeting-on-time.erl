-module(solution).
-export([min_skips/3]).

min_skips(Dist, Speed, MeetingTime) ->
    N = length(Dist),
    Infinity = float(1.0/0.0),

    DP_Array = array:set(0, 0.0, array:new(N + 1, {default, Infinity})),

    FinalDP_Array = lists:foldl(
        fun(RoadDist, AccDP_Array) ->
            NewDP_Array = array:new(N + 1, {default, Infinity}),
            TimeForCurrentRoad = RoadDist / Speed,

            lists:foldl(
                fun(J, CurrentNewDP_Array) ->
                    PrevTimeNoSkip = array:get(J, AccDP_Array),
                    TimeNoSkip =
                        if PrevTimeNoSkip == Infinity -> Infinity;
                           PrevTimeNoSkip == math:floor(PrevTimeNoSkip) and PrevTimeNoSkip /= 0.0 ->
                               PrevTimeNoSkip + 1.0 + TimeForCurrentRoad;
                           true ->
                               math:ceil(PrevTimeNoSkip) + TimeForCurrentRoad
                        end,

                    TimeSkip =
                        if J > 0 ->
                                PrevTimeSkip = array:get(J - 1, AccDP_Array),
                                if PrevTimeSkip == Infinity -> Infinity;
                                   true -> PrevTimeSkip + TimeForCurrentRoad
                                end;
                           true -> Infinity
                        end,

                    MinTimeForJSkips = math:min(TimeNoSkip, TimeSkip),
                    array:set(J, MinTimeForJSkips, CurrentNewDP_Array)
                end,
                NewDP_Array,
                lists:seq(N, 0, -1)
            )
        end,
        DP_Array,
        Dist
    ),

    find_min_skips_idx_array(0, N, FinalDP_Array, MeetingTime, Infinity).

find_min_skips_idx_array(J, MaxJ, FinalDP_Array, MeetingTime, Infinity) ->
    if
        J > MaxJ ->
            -1;
        array:get(J, FinalDP_Array) =< MeetingTime ->
            J;
        true ->
            find_min_skips_idx_array(J + 1, MaxJ, FinalDP_Array, MeetingTime, Infinity)
    end.