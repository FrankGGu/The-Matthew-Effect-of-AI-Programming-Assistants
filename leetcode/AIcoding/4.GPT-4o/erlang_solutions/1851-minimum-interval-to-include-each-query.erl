-module(solution).
-export([min_interval/2]).

min_interval(Intervals, Queries) ->
    SortedIntervals = lists:sort(fun({S1, E1}, {S2, E2}) -> S1 < S2 end, Intervals),
    QueriesWithIndex = lists:map(fun(Q) -> {Q, erlang:monotonic_time()} end, Queries),
    SortedQueries = lists:sort(fun({Q1, _}, {Q2, _}) -> Q1 < Q2 end, QueriesWithIndex),
    min_interval_helper(SortedIntervals, SortedQueries, [], []).

min_interval_helper(_, [], Result, _) -> lists:reverse(Result);
min_interval_helper(Intervals, [{Q, Index} | RestQueries], Result, ActiveIntervals) ->
    NewActiveIntervals = lists:filter(fun({S, E}) -> E >= Q end, ActiveIntervals),
    NewActiveIntervals1 = lists:filter(fun({S, E}) -> S <= Q end, Intervals),
    NewActiveIntervals2 = lists:append(NewActiveIntervals, NewActiveIntervals1),
    NewIntervals = lists:filter(fun({S, E}) -> S > Q end, Intervals),
    Interval = case lists:min(NewActiveIntervals2) of
        {S, E} -> E - S + 1;
        _ -> -1
    end,
    min_interval_helper(NewIntervals, RestQueries, [{Q, Interval} | Result], NewActiveIntervals2).