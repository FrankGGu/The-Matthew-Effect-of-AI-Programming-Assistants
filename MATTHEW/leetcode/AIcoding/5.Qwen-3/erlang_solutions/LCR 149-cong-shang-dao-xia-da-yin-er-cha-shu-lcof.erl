-module(offer_24).
-export([distribute_flowers/1]).

distribute_flowers(Rows) ->
    distribute_flowers(Rows, 0, []).

distribute_flowers([], _, Result) ->
    lists:reverse(Result);
distribute_flowers([Row | Rest], RowIndex, Result) ->
    case RowIndex rem 2 of
        0 ->
            distribute_flowers(Rest, RowIndex + 1, [Row | Result]);
        _ ->
            distribute_flowers(Rest, RowIndex + 1, [lists:reverse(Row) | Result])
    end.