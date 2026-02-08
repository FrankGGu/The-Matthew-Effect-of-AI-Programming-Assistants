-module(solution).
-export([min_time_to_type/1]).

min_time_to_type(Word) ->
    Typewriter = "abcdefghijklmnopqrstuvwxyz",
    min_time(Typewriter, Word, 0, 0).

min_time(_, [], Time, _) -> 
    Time;
min_time(Typewriter, [H | T], Time, Prev) ->
    Current = string:to_integer(binary_to_list(H)),
    IndexH = lists:nth(Current + 1, Typewriter),
    Distance = min(abs(IndexH - Prev), length(Typewriter) - abs(IndexH - Prev)),
    min_time(Typewriter, T, Time + Distance + 1, IndexH).