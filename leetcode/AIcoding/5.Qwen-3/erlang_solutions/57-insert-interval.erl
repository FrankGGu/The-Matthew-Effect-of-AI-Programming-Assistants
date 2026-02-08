-module(insert_interval).
-export([insert/2]).

insert(Interval, []) ->
    [Interval];
insert(Interval, [H | T]) ->
    case is_before(H, Interval) of
        true ->
            [Interval | [H | T]];
        false ->
            case is_after(H, Interval) of
                true ->
                    [H | insert(Interval, T)];
                false ->
                    NewInterval = merge(H, Interval),
                    [NewInterval | insert(NewInterval, T)]
            end
    end.

is_before(A, B) ->
    lists:nth(1, A) < lists:nth(1, B).

is_after(A, B) ->
    lists:nth(1, A) > lists:nth(2, B).

merge(A, B) ->
    [min(lists:nth(1, A), lists:nth(1, B)), max(lists:nth(2, A), lists:nth(2, B))].