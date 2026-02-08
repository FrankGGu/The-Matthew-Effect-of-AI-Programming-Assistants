-module(range_module).
-export([new/0, add_range/3, query_range/2, remove_range/3]).

-record(interval, {start, end}).

new() ->
    [].

add_range(Ranges, Start, End) ->
    NewRange = #interval{start=Start, end=End},
    NewRanges = lists:foldl(fun(I, Acc) ->
        case {I#interval.start < End, Start < I#interval.end} of
            {true, true} -> 
                Acc; 
            _ ->
                [I | Acc]
        end
    end, [], Ranges),
    [NewRange | NewRanges].

query_range(Ranges, Start, End) ->
    lists:all(fun(I) -> I#interval.start <= Start orelse I#interval.end >= End end, Ranges).

remove_range(Ranges, Start, End) ->
    NewRanges = lists:foldl(fun(I, Acc) ->
        case {I#interval.start < End, Start < I#interval.end} of
            {true, true} ->
                case {I#interval.start < Start, I#interval.end > End} of
                    {true, true} ->
                        [{I#interval.start, Start}, {End, I#interval.end} | Acc];
                    {true, false} ->
                        [{I#interval.start, Start} | Acc];
                    {false, true} ->
                        [{End, I#interval.end} | Acc];
                    _ ->
                        [I | Acc]
                end;
            _ ->
                [I | Acc]
        end
    end, [], Ranges),
    lists:filter(fun({S, E}) -> S < E end, NewRanges).