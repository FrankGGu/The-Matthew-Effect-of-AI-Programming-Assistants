-module(partition_labels).
-export([partition_labels/1]).

partition_labels(S) ->
    Last = maps:from_list([{Char, Pos} || {Pos, Char} <- lists:zip(lists:seq(0, length(S)-1), S)]),
    Result = [],
    Start = 0,
    End = 0,
    partition_labels(S, Last, Start, End, Result).

partition_labels(_, _, Start, End, Result) when Start >= length(S) ->
    lists:reverse(Result);
partition_labels(S, Last, Start, End, Result) ->
    CurrentChar = lists:nth(Start+1, S),
    NewEnd = max(End, maps:get(CurrentChar, Last)),
    if
        Start == End ->
            partition_labels(S, Last, Start+1, NewEnd, [End - Start + 1 | Result]);
        true ->
            partition_labels(S, Last, Start+1, NewEnd, Result)
    end.