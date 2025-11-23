-module(data_stream_as_disjoint_intervals).
-export([init/0, add_num/2, get_intervals/1]).

-record(state, {intervals = []}).

init() ->
    #state{}.

add_num(State, Num) ->
    Intervals = State#state.intervals,
    NewIntervals = insert_interval(Intervals, Num),
    State#state{intervals = NewIntervals}.

get_intervals(State) ->
    State#state.intervals.

insert_interval(Intervals, Num) ->
    Sorted = lists:sort(Intervals),
    insert(Sorted, Num, []).

insert([], Num, Acc) ->
    [lists:reverse([Num, Num]) | Acc];
insert([H | T], Num, Acc) ->
    case is_overlap(H, Num) of
        true ->
            Merged = merge(H, Num),
            insert(T, Merged, Acc);
        false ->
            insert(T, Num, [H | Acc])
    end.

is_overlap({L1, R1}, N) ->
    N >= L1 andalso N =< R1.

merge({L1, R1}, N) ->
    {min(L1, N), max(R1, N)}.