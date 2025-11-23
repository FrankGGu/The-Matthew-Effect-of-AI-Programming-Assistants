-module(count_integers_in_intervals).
-export([count/1, insert/2]).

-record(interval, {start, end}).

count(Intervals) ->
    lists:foldl(fun(#interval{start = S, end = E}, Acc) -> Acc + (E - S + 1) end, 0, Intervals).

insert(Intervals, NewInterval) ->
    {NewStart, NewEnd} = NewInterval,
    {Left, Right} = lists:partition(fun(#interval{start = S, end = E}) -> E < NewStart orelse S > NewEnd end, Intervals),
    Merged = case Left ++ Right of
        [] -> [#interval{start = NewStart, end = NewEnd}];
        _ ->
            Starts = [NewStart | [S || #interval{start = S} <- Left ++ Right]],
            Ends = [NewEnd | [E || #interval{end = E} <- Left ++ Right]],
            [#interval{start = lists:min(Starts), end = lists:max(Ends)}]
    end,
    lists:sort(fun(#interval{start = S1}, #interval{start = S2}) -> S1 =< S2 end, Left ++ Merged ++ Right).