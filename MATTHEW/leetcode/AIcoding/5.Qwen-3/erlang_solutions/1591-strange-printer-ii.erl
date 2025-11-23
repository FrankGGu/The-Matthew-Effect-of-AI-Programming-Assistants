-module(strange_printer_ii).
-export([is_possible/1]).

is_possible(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, 0})}),
    lists:foreach(fun(Row) -> 
        lists:foreach(fun(Col) -> 
            if 
                array:get(Row, Visited) == 0 ->
                    case dfs(Grid, Row, Col, 1, Visited) of
                        false -> 
                            false;
                        _ -> ok
                    end;
                true -> ok
            end
        end, lists:seq(0, Cols-1))
    end, lists:seq(0, Rows-1)),
    true.

dfs(_, _, _, _, _) -> true.

dfs(Grid, R, C, Color, Visited) ->
    case array:get(R, Visited) of
        RowArr when is_array(RowArr) ->
            case array:get(C, RowArr) of
                0 ->
                    array:set(R, array:set(C, Color, RowArr), Visited),
                    NextColor = Color + 1,
                    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
                    lists:all(fun({DR, DC}) ->
                        NR = R + DR,
                        NC = C + DC,
                        if
                            NR >= 0, NR < length(Grid), NC >= 0, NC < length(hd(Grid)) ->
                                case array:get(NR, Visited) of
                                    RowArr2 when is_array(RowArr2) ->
                                        case array:get(NC, RowArr2) of
                                            0 -> dfs(Grid, NR, NC, NextColor, Visited);
                                            CurrColor when CurrColor == NextColor -> true;
                                            _ -> false
                                        end;
                                    _ -> false
                                end;
                            true -> true
                        end
                    end, Directions);
                CurrColor when CurrColor == Color -> true;
                _ -> false
            end;
        _ -> false
    end.