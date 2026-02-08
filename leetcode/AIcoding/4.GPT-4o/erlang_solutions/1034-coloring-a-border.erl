-module(solution).
-export([color_border/5]).

color_border(Grid, r, c, color) ->
    {OldColor, visited} = get_color_and_mark(Grid, r, c, element(r, element(1, Grid)), [])
    NewGrid = color_border_helper(Grid, r, c, OldColor, color, visited),
    NewGrid.

get_color_and_mark(Grid, R, C, Color, Visited) ->
    case (R < 1 orelse R > length(Grid) orelse C < 1 orelse C > length(hd(Grid))) of
        true -> {Color, Visited};
        false ->
            case (element(R, Grid) =:= Color) of
                false -> {Color, Visited};
                true ->
                    NewVisited = [{R, C} | Visited],
                    NewVisited1 = get_color_and_mark(Grid, R + 1, C, Color, NewVisited),
                    NewVisited2 = get_color_and_mark(Grid, R - 1, C, Color, NewVisited1),
                    NewVisited3 = get_color_and_mark(Grid, R, C + 1, Color, NewVisited2),
                    get_color_and_mark(Grid, R, C - 1, Color, NewVisited3)
            end
    end.

color_border_helper(Grid, R, C, OldColor, NewColor, Visited) ->
    case lists:member({R, C}, Visited) of
        false -> Grid;
        true ->
            NewRow = lists:map(fun (X) -> if X =:= OldColor -> NewColor; true -> X end end, element(R, Grid)),
            NewGrid = List.replace_element(Grid, R, NewRow),
            color_border_helper(NewGrid, R + 1, C, OldColor, NewColor, Visited),
            color_border_helper(NewGrid, R - 1, C, OldColor, NewColor, Visited),
            color_border_helper(NewGrid, R, C + 1, OldColor, NewColor, Visited),
            color_border_helper(NewGrid, R, C - 1, OldColor, NewColor, Visited)
    end.

-module(List).
-export([replace_element/3]).

replace_element(List, Index, NewValue) ->
    {ok, NewList} = lists:foldl(fun (E, {IndexAcc, Acc}) ->
        case IndexAcc of
            1 -> {IndexAcc - 1, [NewValue | Acc]};
            _ -> {IndexAcc - 1, [E | Acc]}
        end
    end, {Index, []}, lists:reverse(List)),
    lists:reverse(NewList).