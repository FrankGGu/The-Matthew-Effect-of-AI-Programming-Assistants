-spec longest_obstacle_course_at_each_position(Obstacles :: [integer()]) -> [integer()].
longest_obstacle_course_at_each_position(Obstacles) ->
    {Result, _} = lists:foldl(fun(Height, {Res, Tails}) ->
        Index = bisect_right(Tails, Height),
        NewTails = if
            Index == length(Tails) + 1 -> Tails ++ [Height];
            true -> lists:sublist(Tails, Index - 1) ++ [Height] ++ lists:nthtail(Index, Tails)
        end,
        {Res ++ [Index], NewTails}
    end, {[], []}, Obstacles),
    Result.

bisect_right(List, Target) ->
    bisect_right(List, Target, 1, length(List) + 1).

bisect_right([], _, Low, _) -> Low;
bisect_right(List, Target, Low, High) when Low < High ->
    Mid = (Low + High) div 2,
    case lists:nth(Mid, List) of
        Val when Val =< Target -> bisect_right(List, Target, Mid + 1, High);
        _ -> bisect_right(List, Target, Low, Mid)
    end.