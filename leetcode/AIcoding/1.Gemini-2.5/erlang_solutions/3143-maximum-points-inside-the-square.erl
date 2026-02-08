-module(solution).
-export([maximum_points_inside_the_square/2]).

maximum_points_inside_the_square(Points, Tags) ->
    MinSForTag = lists:foldl(
        fun({[X, Y], Tag}, AccMap) ->
            CurrentSForPoint = max(abs(X), abs(Y)),
            maps:update_with(Tag, fun(Val) -> min(Val, CurrentSForPoint) end, CurrentSForPoint, AccMap)
        end,
        #{},
        lists:zip(Points, Tags)
    ),

    MinSListTuples = [{MinS, Tag} || {Tag, MinS} <- maps:to_list(MinSForTag)],

    SortedMinSList = lists:sort(MinSListTuples),

    lists:foldl(
        fun({S_val, _Tag}, AccK) ->
            CurrentK = AccK + 1,
            if S_val =< CurrentK -> CurrentK;
               true -> AccK
            end
        end,
        0,
        SortedMinSList
    ).