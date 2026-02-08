-module(solution).
-export([schedule_course/1]).

-spec schedule_course(Courses :: [[integer()]]) -> integer().
schedule_course(Courses) ->
    SortedCourses = lists:sort(fun([_D1, L1], [_D2, L2]) -> L1 =< L2 end, Courses),

    {_FinalTime, FinalTakenDurations} = lists:foldl(
        fun([Duration, LastDay], {CurrentTime, TakenDurations}) ->
            NewCurrentTime = CurrentTime + Duration,
            NewTakenDurations = insert_sorted_desc(Duration, TakenDurations),

            if
                NewCurrentTime > LastDay ->
                    [LongestDuration | RestTakenDurations] = NewTakenDurations,
                    {NewCurrentTime - LongestDuration, RestTakenDurations};
                true ->
                    {NewCurrentTime, NewTakenDurations}
            end
        end,
        {0, []},
        SortedCourses
    ),
    length(FinalTakenDurations).

insert_sorted_desc(X, []) -> [X];
insert_sorted_desc(X, [H | T]) when X >= H -> [X | [H | T]];
insert_sorted_desc(X, [H | T]) -> [H | insert_sorted_desc(X, T)].