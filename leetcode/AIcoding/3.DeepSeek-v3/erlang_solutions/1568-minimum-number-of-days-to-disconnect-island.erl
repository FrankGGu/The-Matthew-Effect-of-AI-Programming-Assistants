-module(solution).
-export([min_days/1]).

min_days(Grid) ->
    case is_disconnected(Grid) of
        true -> 0;
        false ->
            case min_days_helper(Grid, 1) of
                {found, Days} -> Days;
                not_found -> 2
            end
    end.

is_disconnected(Grid) ->
    case find_land(Grid) of
        none -> true;
        {I, J} ->
            Visited = sets:new(),
            dfs(Grid, I, J, Visited),
            TotalLands = count_lands(Grid),
            sets:size(Visited) < TotalLands
    end.

find_land(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    find_land(Grid, Rows, Cols, 0, 0).

find_land(_, Rows, _, I, _) when I >= Rows -> none;
find_land(Grid, Rows, Cols, I, J) when J >= Cols -> find_land(Grid, Rows, Cols, I + 1, 0);
find_land(Grid, _, _, I, J) ->
    case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
        1 -> {I, J};
        0 -> find_land(Grid, Rows, Cols, I, J + 1)
    end.

dfs(Grid, I, J, Visited) ->
    case is_valid(Grid, I, J) andalso lists:nth(J + 1, lists:nth(I + 1, Grid)) =:= 1 of
        false -> Visited;
        true ->
            case sets:is_element({I, J}, Visited) of
                true -> Visited;
                false ->
                    V1 = sets:add_element({I, J}, Visited),
                    V2 = dfs(Grid, I - 1, J, V1),
                    V3 = dfs(Grid, I + 1, J, V2),
                    V4 = dfs(Grid, I, J - 1, V3),
                    dfs(Grid, I, J + 1, V4)
            end
    end.

is_valid(Grid, I, J) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    I >= 0 andalso I < Rows andalso J >= 0 andalso J < Cols.

count_lands(Grid) ->
    lists:sum([lists:sum(Row) || Row <- Grid]).

min_days_helper(Grid, Day) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),
    case try_flip(Grid, Rows, Cols, 0, 0, Day) of
        {found, Days} -> {found, Days};
        not_found -> min_days_helper(Grid, Day + 1)
    end.

try_flip(_, Rows, _, I, _, _) when I >= Rows -> not_found;
try_flip(Grid, Rows, Cols, I, J, Day) when J >= Cols -> try_flip(Grid, Rows, Cols, I + 1, 0, Day);
try_flip(Grid, Rows, Cols, I, J, Day) ->
    case lists:nth(J + 1, lists:nth(I + 1, Grid)) of
        0 -> try_flip(Grid, Rows, Cols, I, J + 1, Day);
        1 ->
            NewGrid = flip(Grid, I, J),
            case is_disconnected(NewGrid) of
                true -> {found, Day};
                false -> try_flip(Grid, Rows, Cols, I, J + 1, Day)
            end
    end.

flip(Grid, I, J) ->
    Row = lists:nth(I + 1, Grid),
    NewRow = setnth(J + 1, Row, 0),
    setnth(I + 1, Grid, NewRow).

setnth(1, [_|T], X) -> [X|T];
setnth(N, [H|T], X) -> [H|setnth(N-1, T, X)].