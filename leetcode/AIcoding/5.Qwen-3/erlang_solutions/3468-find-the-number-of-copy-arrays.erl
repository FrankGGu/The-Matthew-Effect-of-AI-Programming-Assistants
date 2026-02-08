-module(solution).
-export([num_arrays/1]).

num_arrays(Num) ->
    num_arrays(Num, 1, 0).

num_arrays(Num, Start, Count) when Start > Num ->
    Count;
num_arrays(Num, Start, Count) ->
    Max = Num - Start,
    Len = erlang:integer_to_list(Start),
    case length(Len) of
        1 -> num_arrays(Num, Start + 1, Count + Max);
        _ -> num_arrays(Num, Start + 1, Count)
    end.