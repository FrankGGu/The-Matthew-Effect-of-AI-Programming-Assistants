-module(solution).
-export([countUnguarded/2]).

countUnguarded(Rows, Grid) ->
    {GridMap, Guards} = build_grid(Rows, Grid, 0, 0, dict:new(), []),
    count_unguarded(Rows, GridMap, Guards).

build_grid(_, [], _, _, GridMap, Guards) ->
    {GridMap, Guards};
build_grid(Rows, [Row | Rest], RowIdx, ColIdx, GridMap, Guards) ->
    if
        ColIdx < length(Row) ->
            Cell = lists:nth(ColIdx + 1, Row),
            NewGridMap = dict:store({RowIdx, ColIdx}, Cell, GridMap),
            case Cell of
                0 -> build_grid(Rows, [Row | Rest], RowIdx, ColIdx + 1, NewGridMap, Guards);
                1 -> build_grid(Rows, [Row | Rest], RowIdx, ColIdx + 1, NewGridMap, [{RowIdx, ColIdx} | Guards]);
                _ -> build_grid(Rows, [Row | Rest], RowIdx, ColIdx + 1, NewGridMap, Guards)
            end;
        true ->
            build_grid(Rows, Rest, RowIdx + 1, 0, GridMap, Guards)
    end.

count_unguarded(Rows, GridMap, Guards) ->
    Visited = sets:new(),
    lists:foldl(fun(Guard, Acc) -> mark_guarded(Guard, GridMap, Rows, sets:new()) end, Visited, Guards),
    Count = lists:foldl(fun({R, C}, Acc) ->
        case dict:is_key({R, C}, GridMap) andalso not sets:is_element({R, C}, Visited) of
            true -> Acc + 1;
            false -> Acc
        end
    end, 0, generate_all_cells(Rows)).

generate_all_cells(Rows) ->
    generate_all_cells(Rows, 0, []).

generate_all_cells(_, Rows, Cells) when Rows == 0 ->
    Cells;
generate_all_cells(Rows, RowIdx, Cells) ->
    generate_all_cells(Rows, RowIdx + 1, generate_row_cells(RowIdx, 0, [] ++ Cells)).

generate_row_cells(_, ColIdx, Cells) when ColIdx >= 0 ->
    Cells;
generate_row_cells(RowIdx, ColIdx, Cells) ->
    generate_row_cells(RowIdx, ColIdx + 1, [{RowIdx, ColIdx} | Cells]).

mark_guarded({R, C}, GridMap, Rows, Visited) ->
    Directions = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    lists:foldl(fun({Dr, Dc}, VisitedAcc) ->
        step({R + Dr, C + Dc}, Dr, Dc, GridMap, Rows, VisitedAcc)
    end, Visited, Directions).

step({R, C}, Dr, Dc, GridMap, Rows, Visited) ->
    if
        R >= 0, R < Rows, C >= 0, C < length(lists:nth(R + 1, GridMap)) ->
            case dict:fetch({R, C}, GridMap) of
                0 -> step({R + Dr, C + Dc}, Dr, Dc, GridMap, Rows, sets:add_element({R, C}, Visited));
                1 -> sets:add_element({R, C}, Visited);
                _ -> Visited
            end;
        true ->
            Visited
    end.