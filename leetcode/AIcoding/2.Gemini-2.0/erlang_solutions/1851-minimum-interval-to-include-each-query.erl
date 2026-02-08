-module(minimum_interval).
-export([find_intervals/2]).

find_intervals(intervals, queries) ->
    SortedIntervals = lists:sort(fun({A1, B1}, {A2, B2}) -> A1 < A2 end, intervals),
    SortedQueries = lists:zip(queries, lists:seq(1, length(queries))),
    SortedQueriesWithIndex = lists:sort(fun({Q1, _}, {Q2, _}) -> Q1 < Q2 end, SortedQueries),
    find_intervals_helper(SortedIntervals, SortedQueriesWithIndex, [], priority_queue:new()).

find_intervals_helper([], [], Acc, _) ->
    lists:sort(fun({I1, _}, {I2, _}) -> I1 < I2 end, Acc);
find_intervals_helper([], SortedQueriesWithIndex, Acc, PQ) ->
    lists:sort(fun({I1, _}, {I2, _}) -> I1 < I2 end, Acc);
find_intervals_helper(SortedIntervals, [], Acc, PQ) ->
    lists:sort(fun({I1, _}, {I2, _}) -> I1 < I2 end, Acc);
find_intervals_helper(Intervals, [{Query, Index} | RestQueries], Acc, PQ) ->
    {NewIntervals, ValidIntervals, NewPQ} = update_queue(Intervals, Query, PQ),
    case ValidIntervals of
        [] ->
            find_intervals_helper(NewIntervals, RestQueries, [{Index, -1} | Acc], NewPQ);
        _ ->
            {_, MinLength, _} = lists:min(ValidIntervals),
            find_intervals_helper(NewIntervals, RestQueries, [{Index, MinLength} | Acc], NewPQ)
    end.

update_queue(Intervals, Query, PQ) ->
    {NewIntervals, AddedPQ} = add_to_queue(Intervals, Query, PQ),
    {UpdatedPQ, ValidIntervals} = remove_invalid_intervals(Query, AddedPQ),
    {NewIntervals, ValidIntervals, UpdatedPQ}.

add_to_queue([{A, B} | RestIntervals], Query, PQ) when A =< Query ->
    if Query =< B then
        Length = B - A + 1,
        {RestIntervals, priority_queue:insert({Length, A, B}, PQ)}
    else
        add_to_queue(RestIntervals, Query, PQ)
    end;
add_to_queue(Intervals, _, PQ) ->
    {Intervals, PQ}.

remove_invalid_intervals(Query, PQ) ->
    remove_invalid_intervals_helper(Query, PQ, []).

remove_invalid_intervals_helper(Query, PQ, Acc) ->
    case priority_queue:get_min(PQ) of
        none ->
            {PQ, Acc};
        {ok, {Length, A, B}, NewPQ} ->
            if B < Query then
                remove_invalid_intervals_helper(Query, NewPQ, Acc)
            else
                {PQ, Acc}
            end;
        error ->
            {PQ, Acc}
    end.