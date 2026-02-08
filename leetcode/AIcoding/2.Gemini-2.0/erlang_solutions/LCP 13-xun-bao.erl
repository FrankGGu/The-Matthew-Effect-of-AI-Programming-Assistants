-module(treasure_hunt).
-export([maximum_gold/1]).

maximum_gold(Mine) ->
    {Rows, Cols} = mine_size(Mine),
    memo(Mine, Rows, Cols).

memo(Mine, Rows, Cols) ->
    Memo = dict:new(),
    max_gold(Mine, 0, 0, Rows, Cols, [], Memo).

max_gold(Mine, Row, Col, Rows, Cols, Path, Memo) ->
    case dict:is_key({Row, Col, Path}, Memo) of
        true ->
            dict:fetch({Row, Col, Path}, Memo);
        false ->
            case is_valid(Row, Col, Rows, Cols, Mine, Path) of
                true ->
                    Gold = lists:nth(Row * Cols + Col + 1, Mine),
                    NewPath = [Row * Cols + Col | Path],
                    Down = max_gold(Mine, Row + 1, Col, Rows, Cols, NewPath, Memo),
                    Right = max_gold(Mine, Row, Col + 1, Rows, Cols, NewPath, Memo),
                    Left = max_gold(Mine, Row, Col - 1, Rows, Cols, NewPath, Memo),
                    Up = max_gold(Mine, Row - 1, Col, Rows, Cols, NewPath, Memo),
                    MaxGold = Gold + lists:max([0, Down, Right, Left, Up]),
                    dict:store({Row, Col, Path}, MaxGold, Memo),
                    MaxGold;
                false ->
                    dict:store({Row, Col, Path}, 0, Memo),
                    0
            end
    end.

is_valid(Row, Col, Rows, Cols, Mine, Path) ->
    Row >= 0 andalso Row < Rows andalso Col >= 0 andalso Col < Cols andalso lists:nth(Row * Cols + Col + 1, Mine) > 0 andalso not lists:member(Row * Cols + Col, Path).

mine_size(Mine) ->
    Size = length(Mine),
    Rows = erlang:round(math:sqrt(Size)),
    Cols = erlang:round(math:sqrt(Size)),
    {Rows, Cols}.