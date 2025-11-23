-module(solution).
-export([min_operations/1]).

min_operations(Grid) ->
    min_operations(Grid, 0, 0).

min_operations([], _, _) ->
    0;
min_operations([Row | Rest], Col, Acc) ->
    NextAcc = case Col of
        0 ->
            Acc;
        _ ->
            Prev = lists:nth(Col, Row),
            PrevCol = lists:last(lists:sublist(Row, Col)),
            if
                Prev > PrevCol ->
                    Acc;
                true ->
                    Acc + (PrevCol - Prev + 1)
            end
    end,
    min_operations(Rest, Col + 1, NextAcc).