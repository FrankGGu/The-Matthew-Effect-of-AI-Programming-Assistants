-module(solution).
-export([max_sequence_value/1]).

max_sequence_value(Array) ->
    max_sequence_value(Array, 0, 0, 0).

max_sequence_value([], Max, _, _) ->
    Max;
max_sequence_value([H | T], Max, Current, Index) ->
    case Index of
        0 ->
            NewCurrent = H,
            NewMax = max(Max, H),
            max_sequence_value(T, NewMax, NewCurrent, Index + 1);
        _ ->
            NewCurrent = Current + H,
            NewMax = max(Max, NewCurrent),
            max_sequence_value(T, NewMax, NewCurrent, Index + 1)
    end.