-module(number_of_black_blocks).
-export([countBlackBlocks/1]).

countBlackBlocks(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Map = maps:new(),
    Blocks = lists:foldl(fun(Row, Acc) ->
        lists:foldl(fun({X, Y}, Acc2) ->
            if
                X >= 0, X < Rows, Y >= 0, Y < Cols ->
                    Key = {X, Y},
                    Count = maps:get(Key, Acc2, 0),
                    maps:put(Key, Count + 1, Acc2);
                true ->
                    Acc2
            end
        end, Acc, lists:zip(lists:seq(0, Rows - 1), Row))
    end, Map, Board),
    maps:values(Blocks).

convert_row(_, _, []) -> [];
convert_row(X, Y, [H | T]) ->
    if H == $B -> [{X, Y} | convert_row(X, Y + 1, T)];
       true -> convert_row(X, Y + 1, T)
    end.