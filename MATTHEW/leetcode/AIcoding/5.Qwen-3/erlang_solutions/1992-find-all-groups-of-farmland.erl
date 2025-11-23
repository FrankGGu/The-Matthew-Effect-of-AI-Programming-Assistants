-module(solution).
-export([find_farmland_groups/1]).

find_farmland_groups(Rem) ->
    Rows = length(Rem),
    Cols = length(hd(Rem)),
    Visited = array:new({0, Rows-1}, {default, array:new({0, Cols-1}, {default, false})}),
    Result = [],
    find_groups(Rem, 0, 0, Visited, Result).

find_groups(_, _, Cols, _, Result) when Cols >= Cols -> Result;
find_groups(Rem, Row, Col, Visited, Result) when Row >= length(Rem) -> Result;
find_groups(Rem, Row, Col, Visited, Result) ->
    case array:get(Row, Visited) of
        RowArr when array:get(Col, RowArr) == false ->
            case lists:nth(Row+1, Rem) of
                RowList when lists:nth(Col+1, RowList) == 1 ->
                    NewVisited = mark_visited(Rem, Row, Col, Visited),
                    {EndRow, EndCol} = find_end(Rem, Row, Col),
                    Result2 = [[Row, Col, EndRow, EndCol] | Result],
                    find_groups(Rem, Row, Col + 1, NewVisited, Result2);
                _ ->
                    find_groups(Rem, Row, Col + 1, Visited, Result)
            end;
        _ ->
            find_groups(Rem, Row, Col + 1, Visited, Result)
    end.

mark_visited(_, _, _, Visited) when false -> Visited;
mark_visited(Rem, Row, Col, Visited) ->
    NewRowArr = array:set(Col, true, array:get(Row, Visited)),
    NewVisited = array:set(Row, NewRowArr, Visited),
    mark_visited_row(Rem, Row, Col, NewVisited).

mark_visited_row(_, _, _, Visited) when false -> Visited;
mark_visited_row(Rem, Row, Col, Visited) ->
    case Row < length(Rem) andalso lists:nth(Row+1, Rem) of
        RowList when lists:nth(Col+1, RowList) == 1 ->
            NewRowArr = array:set(Col, true, array:get(Row, Visited)),
            NewVisited = array:set(Row, NewRowArr, Visited),
            mark_visited_row(Rem, Row + 1, Col, NewVisited);
        _ ->
            Visited
    end.

find_end(_, Row, Col) when Row >= length(Rem) -> {Row, Col};
find_end(Rem, Row, Col) ->
    case lists:nth(Row+1, Rem) of
        RowList when lists:nth(Col+1, RowList) == 1 ->
            find_end(Rem, Row + 1, Col);
        _ ->
            {Row, Col}
    end.