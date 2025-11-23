-module(minimum_interval_to_include_each_query).
-export([minInterval/2]).

minInterval(Queries, Intervals) ->
    SortedIntervals = lists:sort(fun({A, B}, {C, D}) -> A < C end, Intervals),
    SortedQueries = lists:sort(fun({I, _}) -> I end, Queries),
    Results = lists:zipwith(fun(Q, _) -> -1 end, SortedQueries, []),
    minInterval(SortedQueries, SortedIntervals, Results, 0, 0).

minInterval([], _, Results, _, _) ->
    Results;
minInterval([Q | RestQ], Intervals, Results, Index, ResultIndex) ->
    {Query, Idx} = Q,
    minIntervalHelper(Query, Intervals, Results, Index, ResultIndex, 0).

minIntervalHelper(Query, [], Results, _, ResultIndex, MinLen) ->
    NewResults = lists:sublist(Results, ResultIndex) ++ [-1] ++ lists:nthtail(ResultIndex + 1, Results),
    minInterval(RestQ, [], NewResults, 0, ResultIndex + 1);
minIntervalHelper(Query, [Interval | RestIntervals], Results, Index, ResultIndex, MinLen) ->
    {Start, End} = Interval,
    if
        Start > Query ->
            minIntervalHelper(Query, RestIntervals, Results, Index + 1, ResultIndex, MinLen);
        true ->
            if
                End >= Query ->
                    Len = End - Start + 1,
                    NewMinLen = if MinLen == 0 -> Len; true -> min(MinLen, Len) end,
                    minIntervalHelper(Query, RestIntervals, Results, Index + 1, ResultIndex, NewMinLen);
                true ->
                    minIntervalHelper(Query, RestIntervals, Results, Index + 1, ResultIndex, MinLen)
            end
    end.

minIntervalHelper(_, [], Results, _, ResultIndex, MinLen) ->
    NewResults = lists:sublist(Results, ResultIndex) ++ [MinLen] ++ lists:nthtail(ResultIndex + 1, Results),
    minInterval([], [], NewResults, 0, ResultIndex + 1).