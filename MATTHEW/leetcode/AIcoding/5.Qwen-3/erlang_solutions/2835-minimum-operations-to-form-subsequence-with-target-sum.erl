-module(min_operations).
-export([min_operations/1]).

min_operations(Numbers) ->
    min_operations(Numbers, 0, 0).

min_operations([], _, Acc) ->
    Acc;
min_operations([N | T], Pos, Acc) ->
    case N of
        0 -> min_operations(T, Pos + 1, Acc);
        _ -> min_operations(T, Pos + 1, Acc + 1)
    end.