-module(solution).
-export([convert/2]).

convert(Flat, Shape) ->
    convert(Flat, Shape, 1, []).

convert([], _, _, Acc) ->
    lists:reverse(Acc);
convert(Flat, [Rows, Cols], Index, Acc) ->
    case Index rem Cols of
        0 ->
            convert(lists:nthtail(Cols, Flat), [Rows, Cols], Index + 1, [lists:sublist(Flat, Cols) | Acc]);
        _ ->
            convert(lists:nthtail(1, Flat), [Rows, Cols], Index + 1, Acc)
    end.