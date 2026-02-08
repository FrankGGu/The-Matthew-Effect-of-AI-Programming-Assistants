-module(mota_game).
-export([minInitialHealth/1]).

minInitialHealth(Dungeon) ->
    Rows = length(Dungeon),
    Cols = length(hd(Dungeon)),
    Health = lists:duplicate(Rows, lists:duplicate(Cols, 0)),
    Health1 = lists:foldr(fun({Row, Col}, Acc) ->
        CurrentCell = lists:nth(Col, lists:nth(Row, Dungeon)),
        MinHealth = case Row of
            Rows -> max(1, 1 - CurrentCell);
            _ -> max(1, (lists:nth(Col, lists:nth(Row + 1, Acc)) - CurrentCell))
        end,
        lists:replace(Row, lists:replace(Col, MinHealth, lists:nth(Row, Acc)), Acc)
    end, Health, lists:seq(0, Rows - 1) -- lists:seq(0, Cols - 1)),
    lists:nth(1, lists:nth(1, Health1)).