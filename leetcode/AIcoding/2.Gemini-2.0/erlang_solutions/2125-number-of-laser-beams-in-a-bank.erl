-module(laser_beams).
-export([number_of_beams/1]).

number_of_beams(Bank) ->
    number_of_beams(Bank, 0, 0).

number_of_beams([], _, Acc) ->
    Acc;
number_of_beams([Row | Rest], Prev, Acc) ->
    Ones = count_ones(Row),
    if
        Ones > 0 ->
            number_of_beams(Rest, Ones, Acc + Prev * Ones);
        true ->
            number_of_beams(Rest, Prev, Acc)
    end.

count_ones(Row) ->
    count_ones(Row, 0).

count_ones([], Acc) ->
    Acc;
count_ones([C | Rest], Acc) ->
    if
        C == $1 ->
            count_ones(Rest, Acc + 1);
        true ->
            count_ones(Rest, Acc)
    end.