-module(island_perimeter).
-export([island_perimeter/1]).

island_perimeter(Grid) ->
    island_perimeter(Grid, 0, 0, 0).

island_perimeter([], _, _, Perimeter) ->
    Perimeter;
island_perimeter([Row|Rest], RowIndex, ColMax, Perimeter) ->
    island_perimeter(Row, RowIndex, Rest, 0, ColMax, Perimeter).

island_perimeter([], _, Rest, ColIndex, _, Perimeter) ->
    island_perimeter(Rest, _ + 1, ColIndex, Perimeter);
island_perimeter([Cell|Rest], RowIndex, RestRows, ColIndex, ColMax, Perimeter) ->
    case Cell of
        1 ->
            Up = case RowIndex > 0 of
                     true ->
                         case lists:nth(RowIndex - 1, RestRows) of
                             RowBefore ->
                                 case lists:nth(ColIndex + 1, RowBefore) of
                                     1 -> 0;
                                     _ -> 1
                                 end;
                             _ -> 1
                         end;
                     false ->
                         1
                 end,
            Down = case RowIndex < length(RestRows) of
                       true ->
                           case lists:nth(RowIndex, RestRows) of
                               RowAfter ->
                                   case lists:nth(ColIndex + 1, RowAfter) of
                                       1 -> 0;
                                       _ -> 1
                                   end;
                               _ -> 1
                           end;
                       false ->
                           1
                   end,
            Left = case ColIndex > 0 of
                       true ->
                           case lists:nth(ColIndex, [Cell|Rest]) of
                               1 -> 0;
                               _ -> 1
                           end;
                       false ->
                           1
                   end,
            Right = case ColIndex < ColMax - 1 of
                        true ->
                            case lists:nth(ColIndex + 2, [Cell|Rest]) of
                                1 -> 0;
                                _ -> 1
                            end;
                        false ->
                            1
                    end,
            NewPerimeter = Perimeter + Up + Down + Left + Right,
            island_perimeter(Rest, RowIndex, RestRows, ColIndex + 1, ColMax, NewPerimeter);
        _ ->
            island_perimeter(Rest, RowIndex, RestRows, ColIndex + 1, ColMax, Perimeter)
    end.