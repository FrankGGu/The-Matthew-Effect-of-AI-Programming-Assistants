-module(solution).
-export([has_valid_path/1]).

has_valid_path(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    Start = find_start(Grid, 0, 0),
    End = {Rows-1, Cols-1},
    has_valid_path(Grid, Start, End, #{}).

find_start([], _, _) -> {0,0};
find_start([Row|Rest], RowIdx, ColIdx) ->
    case lists:keymember(1, 1, Row) of
        true -> {RowIdx, lists:keyfind(1, 1, Row) -- 1};
        false -> find_start(Rest, RowIdx+1, 0)
    end.

has_valid_path(_, {R,C}, {R,C}, _) -> true;
has_valid_path(Grid, {R,C}, End, Visited) ->
    Directions = get_directions(Grid, R, C),
    lists:any(fun({NR, NC}) ->
        if
            NR >= 0, NR < length(Grid), NC >= 0, NC < length(hd(Grid)), not maps:is_key({NR,NC}, Visited) ->
                NewVisited = maps:put({NR,NC}, true, Visited),
                has_valid_path(Grid, {NR,NC}, End, NewVisited);
            true -> false
        end
    end, Directions).

get_directions(Grid, R, C) ->
    Cell = lists:nth(C+1, lists:nth(R+1, Grid)),
    case Cell of
        1 -> [{R, C-1}, {R, C+1}];
        2 -> [{R-1, C}, {R+1, C}];
        3 -> [{R, C-1}, {R+1, C}];
        4 -> [{R, C+1}, {R+1, C}];
        5 -> [{R, C-1}, {R-1, C}];
        6 -> [{R, C+1}, {R-1, C}]
    end.