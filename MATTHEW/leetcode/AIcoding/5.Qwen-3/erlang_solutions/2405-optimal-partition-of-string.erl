-module(optimal_partition_of_string).
-export([partition_string/1]).

partition_string(S) ->
    partition_string(S, 0, 0, []).

partition_string([], _Pos, _Count, _Chars) ->
    _Count;
partition_string([C | T], Pos, Count, Chars) ->
    case lists:member(C, Chars) of
        true ->
            partition_string(T, Pos + 1, Count + 1, [C]);
        false ->
            partition_string(T, Pos + 1, Count, [C | Chars])
    end.