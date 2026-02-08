-module(minimum_increments).
-export([min_number_of_increments/1]).

min_number_of_increments(Target) ->
    min_number_of_increments(Target, 0, 0).

min_number_of_increments([], Acc, _) ->
    Acc;
min_number_of_increments([H|T], Acc, Prev) ->
    case H > Prev of
        true ->
            min_number_of_increments(T, Acc + (H - Prev), H);
        false ->
            min_number_of_increments(T, Acc, H)
    end.