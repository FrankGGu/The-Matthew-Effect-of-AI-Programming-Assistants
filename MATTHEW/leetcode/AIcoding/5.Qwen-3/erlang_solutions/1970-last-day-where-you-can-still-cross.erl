-module(last_day_where_you_can_still_cross).
-export([highestDay/1]).

highestDay(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    {Min, Max} = {1, Rows * Cols},
    binary_search(Grid, Min, Max, 0).

binary_search(_, L, R, Ans) when L > R ->
    Ans;
binary_search(Grid, L, R, Ans) ->
    Mid = (L + R) div 2,
    if can_cross(Grid, Mid) ->
        binary_search(Grid, Mid + 1, R, Mid);
    true ->
        binary_search(Grid, L, Mid - 1, Ans)
    end.

can_cross(Grid, Day) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Visited = array:new(Rows * Cols, {default, false}),
    Queue = queue:from_list([{0, 0}]),
    array:set(0, true, Visited),
    Dir = [{-1, 0}, {1, 0}, {0, -1}, {0, 1}],
    can_cross_helper(Grid, Day, Rows, Cols, Queue, Visited, Dir).

can_cross_helper(_, _, _, _, Q, Visited, _) when queue:is_empty(Q) ->
    false;
can_cross_helper(Grid, Day, Rows, Cols, Q, Visited, Dir) ->
    {{value, {R, C}}, NewQ} = queue:out(Q),
    case {R, C} of
        {_, C} when C == Cols - 1 -> true;
        _ ->
            lists:foreach(
                fun({DR, DC}) ->
                    NR = R + DR,
                    NC = C + DC,
                    Index = NR * Cols + NC,
                    if
                        NR >= 0, NR < Rows, NC >= 0, NC < Cols,
                        is_water(Grid, NR, NC, Day),
                        not array:get(Index, Visited) ->
                            array:set(Index, true, Visited),
                            queue:in({NR, NC}, NewQ);
                        _ -> ok
                    end
                end,
                Dir
            ),
            can_cross_helper(Grid, Day, Rows, Cols, NewQ, Visited, Dir)
    end.

is_water(Grid, R, C, Day) ->
    GridRow = lists:nth(R + 1, Grid),
    Val = lists:nth(C + 1, GridRow),
    Val >= Day.